setl textwidth=80
setl keywordprg=:help
if !&readonly
    setlocal ff=unix
endif

let b:foldtext_strip_comments = v:true

" make line continuation `\` less indented (default is *3)
" let g:vim_indent_cont = shiftwidth() * 2


inorea <buffer> augr augroup  \| au!<CR>
            \au BufRead * echo "hello world"<CR>
            \augroup END<Up><Up><Left><Left><Left>
            \<C-R>=Eatchar('\s')<CR>
