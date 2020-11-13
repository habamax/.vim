if executable('yapf')
    command -buffer Format :%!yapf
endif


let b:foldchar = ''

" func! HabaPythonFold() abort
"     let line = getline(v:lnum)
"     if line =~? '^\s*$'
"         return -1
"     endif

"     let indent = indent(v:lnum) / &sw
"     let indent_next = indent(nextnonblank(v:lnum+1))/&sw

"     if indent_next > indent && line =~ ':\s*$'
"         return ">" . indent_next
"     else
"         return indent
"     endif
" endfunc
" setlocal foldexpr=HabaPythonFold()
" setlocal foldmethod=expr
setlocal foldignore=


