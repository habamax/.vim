vim9script

import autoload 'dir.vim'

nnoremap <bs> <scriptcmd>dir.Open()<CR>
command! -nargs=? -complete=dir Dir dir.Open(<f-args>)
