vim9script

if exists('g:loaded_shout')
    finish
endif
g:loaded_shout = 1

import autoload 'shout.vim'

command! -nargs=1 -bang Sh shout.CaptureOutput(<q-args>, empty(<q-bang>) ? true : false)
