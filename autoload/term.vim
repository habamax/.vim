vim9script
# import autoload 'term.vim'
# xnoremap <expr> <space>t term.Send()
# nnoremap <expr> <space>t term.Send()
# nnoremap <expr> <space>tt term.Send() .. '_'

# handle python repl
# 1. remove indent of the first non empty line
# 2. insert empty line before top level statements
def PrepareText(text: list<string>): list<string>
    var result: list<string> = []
    if empty(text)
        return result
    endif
    var indent_remove = -1
    for line in text
        if indent_remove == -1 && line !~ '^\s*$'
            indent_remove = line->matchstr('^\s*')->len()
        endif
        var line_res = line->substitute('^\s\{' .. indent_remove .. '}', '', '')
        if line_res =~ '^$'
            line_res = ' '
        endif
        if line_res =~ '^\S' && len(result) > 0
            result->add("")
        endif
        result->add(line_res)
    endfor
    return result
enddef

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

    var region_type = {line: "V", char: "v", block: "\<c-v>"}
    var text = PrepareText(getregion(getpos("'["),
                                     getpos("']"),
                                     {type: get(region_type, args[0])}))
    if len(text) > 0 && text[-1] =~ '^\s\+'
        text[-1] ..= "\r"
    endif
    term_sendkeys(winbufnr(term_window), text->join("\r") .. "\r")

    return ""
enddef
