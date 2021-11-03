setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

let g:vim_indent_cont = 6

func! s:strip_vim_syntax() abort
    hi link vimVar Normal
    hi link vimOper Normal
    hi link vimParenSep Normal
    hi link vimSep Normal
endfunc

call s:strip_vim_syntax()

augroup strip_vim_syntax | au!
    au ColorScheme * call s:strip_vim_syntax()
augroup END
