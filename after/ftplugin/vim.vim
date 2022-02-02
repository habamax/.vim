vim9script

setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

def StripSyntax()
    hi link vimVar Normal
    hi link vimOper Normal
    hi link vimParenSep Normal
    hi link vimSep Normal
enddef

StripSyntax()

augroup strip_vim_syntax | au!
    au ColorScheme * call StripSyntax()
augroup END

def Fold()
    silent! norm! zf/^enddef/e
enddef

nnoremap <silent><buffer> <F2> :g#^def\s#silent! exe "norm! zd" \| call <sid>Fold()<CR>
nnoremap <F5> :so%<CR>
