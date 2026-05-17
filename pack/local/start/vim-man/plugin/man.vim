vim9script

if exists('g:loaded_man')
    finish
endif
g:loaded_man = 1

import autoload 'man.vim'

command! -nargs=_ -bang -complete=customlist,man.Complete Man man.CaptureOutput(<q-args>)

set keywordprg=:Man
