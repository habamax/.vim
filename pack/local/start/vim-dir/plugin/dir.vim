vim9script

import autoload 'dir.vim'

command! -nargs=? Dir dir.Open(<f-args>)
