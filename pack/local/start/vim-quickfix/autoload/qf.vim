vim9script

def IsLocationList(): bool
    return getloclist(winnr(), {'filewinid': 0}).filewinid > 0
enddef

export def QuickFixText(info: dict<any>): list<string>
    var items = []
    if info.quickfix == 1
        items = getqflist({id: info.id, items: 1}).items
    else
        items = getloclist(info.winid, {id: info.id, items: 1}).items
    endif
    var l = []
    for idx in range(info.start_idx - 1, info.end_idx - 1)
        if items[idx].valid
            var text = fnamemodify(bufname(items[idx].bufnr), ':p:~:.')
            if items[idx].lnum != 0
                text ..= $":{items[idx].lnum}"
            endif
            if items[idx].col != 0
                text ..= $":{items[idx].col}"
            endif
            text ..= $":{items[idx].text}"
            add(l, text)
        else
            add(l, items[idx].text)
        endif
    endfor
    return l
enddef

export def View()
    var winid = win_getid()
    exe "normal! \<CR>"
    if winid == win_getid()
        return
    endif
    normal! zz
    if exists(":BlinkLine") == 2
        BlinkLine
    endif
    wincmd p
enddef

export def Next()
    try
        if IsLocationList()
            lnext
        else
            cnext
        endif
        if exists(":BlinkLine") == 2
            BlinkLine
        endif
        wincmd p
    catch
    endtry
enddef

export def Prev()
    try
        if IsLocationList()
            lprev
        else
            cprev
        endif
        if exists(":BlinkLine") == 2
            BlinkLine
        endif
        wincmd p
    catch
    endtry
enddef

try
    import autoload "popup.vim"
    def GoToLocation()
        var loc = {}
        if getwininfo(win_getid())[0].loclist
            loc = getloclist(winnr(), {items: 1, title: 1})
        elseif getwininfo(win_getid())[0].quickfix
            loc = getqflist({items: 1, title: 1})
        endif
        if empty(loc)
            return
        endif

        var items = loc.items->mapnew((_, v) => {
            var vt = v.text->split('^\[.\{-}\]\s*\zs')
            var pretext = len(vt) > 1 ? vt[0] : ''
            var text = vt[len(vt) - 1]
            return {
                lnum: v.lnum,
                col: v.col,
                bufnr: v.bufnr,
                pretext: pretext,
                text: text,
                posttext: $' ({v.lnum})'}
        })

        popup.Select(loc.title, items,
            (res, key) => {
                # TODO: make it work like opening from quickfix
                exe $"sbuffer {res.bufnr}"
                call setcursorcharpos(res.lnum, res.col)
                normal! zz
            },
            (winid) => {
                win_execute(winid, "syn match PopupSelectSymbolKind '^\\[.\\+\\]'")
                win_execute(winid, "syn match PopupSelectSymbolLine '\\s(\\d\\+)$'")
                hi def link PopupSelectSymbolKind Identifier
                hi def link PopupSelectSymbolLine Comment
            })
    enddef

    augroup qfgoto
        au Filetype qf nnoremap <buffer><nowait> z <scriptcmd>GoToLocation()<cr>
    augroup END
catch
endtry
