setl textwidth=80
setl keywordprg=:help
if !&readonly
    setlocal ff=unix
endif

let b:foldtext_strip_comments = v:true


setlocal path+=plugin/**
setlocal path+=autoload/**
setlocal path+=colortemplate/**
setlocal path+=after/**
setlocal path+=compiler/**
setlocal path+=colors/**


inorea <buffer> augr augroup  \| au!<CR>
            \au BufRead * echo "hello world"<CR>
            \augroup END<Up><Up><Left><Left><Left>
            \<C-R>=Eatchar('\s')<CR>
