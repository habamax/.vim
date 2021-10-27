" Vim reST indent file
" Language: reStructuredText
" Maintainer: Maxim Kim <habamax@gmail.com>

" if exists("b:did_indent")
"     finish
" endif
let b:did_indent = 1


let undo_opts = "setl indentexpr< indentkeys< nosmartindent<"

if exists('b:undo_indent')
    let b:undo_indent .= "|" . undo_opts
else
    let b:undo_indent = undo_opts
endif

setlocal indentexpr=ReStructuredTextIndent()
setlocal indentkeys=!^F,o,O
setlocal nosmartindent

" if exists("*ReStructuredTextIndent")
"     finish
" endif

let s:itemize = '^\s*[-*+]\s'
let s:enumeration = '^\s*\%(\d\+\|#\)\.\s\+'
let s:directive = '^\s*\.\.\(\s\+\|$\)'

func! ReStructuredTextIndent() abort
    let pplnum = prevnonblank(v:lnum - 1)

    let pind = indent(v:lnum - 1)
    let ppind = indent(pplnum)

    let pline = getline(v:lnum - 1)
    let ppline = getline(pplnum)

    " prev non blank is a .. directive
    " add single indent
    if ppline =~ s:directive && v:lnum - pplnum == 1
        echo "attributes" v:lnum pplnum 
        return ppind + shiftwidth()
    endif

    " previous line is empty
    " use previous non blank indent
    if v:lnum - pplnum >= 2
        echo "previuos line is empty" v:lnum pplnum
        return -1
    endif

    echo "last"

    " return previous indent
    return pind

    " let psnum = s:get_paragraph_start()

    " if line =~ s:itemize
    "     let ind += 2
    " elseif line =~ s:enumeration
    "     let ind += matchend(line, s:enumeration)
    " endif

    " let line = getline(v:lnum - 1)

    " " Indent :FIELD: lines.  Don’t match if there is no text after the field or
    " " if the text ends with a sent-ender.
    " if line =~ '^:.\+:\s\{-1,\}\S.\+[^.!?:]$'
    "     return matchend(line, '^:.\{-1,}:\s\+')
    " endif

    " if line =~ '^\s*$'
    "     execute lnum
    "     call search('^\s*\%([-*+]\s\|\%(\d\+\|#\)\.\s\|\.\.\|$\)', 'bW')
    "     let line = getline('.')
    "     if line =~ s:itemize
    "         let ind -= 2
    "     elseif line =~ s:enumeration
    "         let ind -= matchend(line, s:enumeration)
    "     elseif line =~ '^\s*\.\.'
    "         let ind -= shiftwidth()
    "     endif
    " endif

    " return ind
endfunc
