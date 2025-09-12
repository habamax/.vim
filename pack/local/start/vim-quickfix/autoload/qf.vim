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
    exe "normal! \<CR>zz"
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
