vim9script

setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

def Fold()
    silent! norm! zf/^enddef/e
enddef

nnoremap <silent><buffer> <F2> :g#^def\s#silent! exe "norm! zd" \| call <sid>Fold()<CR>
nnoremap <F5> :update<CR>:so%<CR>
