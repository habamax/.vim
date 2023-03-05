vim9script

if exists('g:loaded_run')
    finish
endif
g:loaded_run = 1

import autoload 'run.vim'

command! -nargs=1 -complete=file R run.CaptureOutput(<f-args>)
