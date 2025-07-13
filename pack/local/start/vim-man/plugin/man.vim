vim9script

if exists('g:loaded_man')
    finish
endif
g:loaded_man = 1

import autoload 'man.vim'

command! -nargs=1 -bang -complete=shellcmd Man man.CaptureOutput(<q-args>)
