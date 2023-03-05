vim9script

if exists("b:did_ftplugin")
    finish
endif

b:did_ftplugin = 1

b:undo_ftplugin = 'exe "nunmap <buffer> <cr>"'

import autoload 'run.vim'

nnoremap <buffer> <cr> <scriptcmd>run.OpenFile()<cr>
