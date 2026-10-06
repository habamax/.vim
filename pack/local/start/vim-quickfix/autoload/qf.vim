vim9script

def IsLocationList(): bool
    return getloclist(winnr(), {'filewinid': 0}).filewinid > 0
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

        var items = loc.items->mapnew((idx, v) => {
            var vt = v.text->split('^\s*\[.\{-}\]\s*\zs')
            var pretext = len(vt) > 1 ? vt[0] : ''
            var text = vt[len(vt) - 1]
            return {
                qflnum: idx + 1,
                pretext: pretext,
                text: text,
                posttext: $' ({v.lnum})'}
        })

        popup.Select(loc.title, items,
            (res, key) => {
                exe $":{res.qflnum}"
                exe "normal! \<CR>"
            },
            (winid) => {
                win_execute(winid, "syn match PopupSelectSymbolKind '^\\s*\\[.\\+\\]'")
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
