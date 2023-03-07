vim9script

if exists("b:did_ftplugin")
    finish
endif

b:did_ftplugin = 1

b:undo_ftplugin = 'exe "nunmap <buffer> <cr>"'
b:undo_ftplugin ..= '| exe "nunmap <buffer> <space><cr>"'

import autoload 'shellcmd.vim'

nnoremap <buffer> <cr> <scriptcmd>shellcmd.OpenFile()<cr>
nnoremap <buffer> <space><cr> <scriptcmd>shellcmd.OpenFile("tab")<cr>
