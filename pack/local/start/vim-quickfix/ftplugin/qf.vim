vim9script

import autoload 'qf.vim'

nnoremap <buffer> o <scriptcmd>qf.View()<CR>
nnoremap <buffer> gq <scriptcmd>wincmd c<CR>
nnoremap <buffer> J <scriptcmd>qf.Next()<CR>
nnoremap <buffer> K <scriptcmd>qf.Prev()<CR>
