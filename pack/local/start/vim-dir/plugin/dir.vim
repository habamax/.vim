vim9script

import autoload 'dir.vim'

command! -nargs=? -complete=dir Dir dir.Open(<f-args>)
