vim9script

if exists('g:loaded_shellcmd')
    finish
endif
g:loaded_shellcmd = 1

import autoload 'shellcmd.vim'

command! -nargs=1 Sh shellcmd.CaptureOutput(<f-args>)
