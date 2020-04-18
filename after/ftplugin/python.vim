if executable('yapf')
    command -buffer Format :%!yapf
endif


let b:foldchar = ''

func! FoldIndent() abort
    let indent = indent(v:lnum)/&sw
    let indent_next = indent(nextnonblank(v:lnum+1))/&sw
    let line = getline(v:lnum)

    if indent_next > indent && line !~ '^\s*$'
        return ">" . (indent+1)
        return "<" . (indent+1)
    elseif indent != 0
        return indent
    else 
        return -1
    endif
endfunc
setlocal foldexpr=FoldIndent()
setlocal foldmethod=expr
setlocal foldignore=


