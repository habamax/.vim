if executable('yapf')
    " pip install yapf
    command -buffer Fmt :%!yapf
    let &l:formatprg = "yapf"
endif

let b:foldchar = ''
setlocal foldignore=


