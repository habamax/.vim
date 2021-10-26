" Vim reST indent file
" Language: reStructuredText
" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

" b:undo_indent
" For undoing the effect of an indent script, the b:undo_indent variable should
" be set accordingly.
setlocal indentexpr=ReStructuredTextIndent()
setlocal indentkeys=!^F,o,O
setlocal nosmartindent

if exists("*ReStructuredTextIndent")
    finish
endif

let s:itemization_pattern = '^\s*[-*+]\s'
let s:enumeration_pattern = '^\s*\%(\d\+\|#\)\.\s\+'
let s:note_pattern = '^\.\. '

func! s:get_paragraph_start()
    let paragraph_mark_start = getpos("'{")[1]
    return getline(paragraph_mark_start) =~ '\S' ? paragraph_mark_start : paragraph_mark_start + 1
endfunc

func! ReStructuredTextIndent()
    let lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    endif

    let ind = indent(lnum)
    let line = getline(lnum)

    let psnum = s:get_paragraph_start()
    if psnum != 0
        if getline(psnum) =~ s:note_pattern
            let ind = shiftwidth()
        endif
    endif

    if line =~ s:itemization_pattern
        let ind += 2
    elseif line =~ s:enumeration_pattern
        let ind += matchend(line, s:enumeration_pattern)
    endif

    let line = getline(v:lnum - 1)

    " Indent :FIELD: lines.  Don’t match if there is no text after the field or
    " if the text ends with a sent-ender.
    if line =~ '^:.\+:\s\{-1,\}\S.\+[^.!?:]$'
        return matchend(line, '^:.\{-1,}:\s\+')
    endif

    if line =~ '^\s*$'
        execute lnum
        call search('^\s*\%([-*+]\s\|\%(\d\+\|#\)\.\s\|\.\.\|$\)', 'bW')
        let line = getline('.')
        if line =~ s:itemization_pattern
            let ind -= 2
        elseif line =~ s:enumeration_pattern
            let ind -= matchend(line, s:enumeration_pattern)
        elseif line =~ '^\s*\.\.'
            let ind -= shiftwidth()
        endif
    endif

    return ind
endfunc
