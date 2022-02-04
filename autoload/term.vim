vim9script

# xnoremap <expr> <space>r term#Send()
# nnoremap <expr> <space>r term#Send()
# nnoremap <expr> <space>rr term#Send() .. '_'
export def Send(...args: list<any>): string
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif

    var terms = getwininfo()->filter((_, v) => getbufvar(v.bufnr, '&buftype') == 'terminal')
    if len(terms) < 1
        echomsg "There is no visible terminal!"
        return ""
    endif

    if len(terms) > 1
        echomsg "Too many terminals open!"
        return ""
    endif

    var term_window = terms[0].winnr

    var sel_save = &selection
    &selection = "inclusive"
    var reg_save = getreg('"')
    var clipboard_save = &clipboard
    &clipboard = ""

    var commands = {"line": "'[V']y", "char": "`[v`]y", "block": "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' .. get(commands, args[0], '')

    var text = split(@", "\n")
    if len(text) > 0 && text[-1] =~ '^\s\+'
        text[-1] ..= "\r"
    endif
    term_sendkeys(winbufnr(term_window), text->join("\r") .. "\r")

    &selection = sel_save
    setreg('"', reg_save)
    &clipboard = clipboard_save
    return ""
enddef
