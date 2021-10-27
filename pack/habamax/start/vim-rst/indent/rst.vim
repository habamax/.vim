" Vim reST indent file
" Language: reStructuredText
" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

let undo_opts = "setl inde< indk< si<"

if exists('b:undo_indent')
    let b:undo_indent .= "|" . undo_opts
else
    let b:undo_indent = undo_opts
endif

setlocal indentexpr=ReStructuredTextIndent()
setlocal indentkeys=!^F,o,O
setlocal nosmartindent

if exists("*ReStructuredTextIndent")
    finish
endif

func! ReStructuredTextIndent() abort
    let pplnum = prevnonblank(v:lnum - 1)

    let pind = indent(v:lnum - 1)
    let ppind = indent(pplnum)

    let line = getline(v:lnum)
    let pline = getline(v:lnum - 1)
    let ppline = getline(pplnum)

    " prev non blank is a .. directive
    " add single indent
    if ppline =~ '^\s*\.\.\(\s\+\|$\)' && v:lnum - pplnum == 1
        return ppind + shiftwidth()
    endif

    " previous line is empty
    " use previous non blank indent
    if v:lnum - pplnum >= 2
        return -1
    endif

    " indent fancy table... maybe?

    " indent simple table... maybe?

    " indent list items according to formatlistpat
    if pline =~ &l:formatlistpat && line !~ &l:formatlistpat
        return matchend(pline, &l:formatlistpat)
    endif

    " return previous indent
    return pind
endfunc
