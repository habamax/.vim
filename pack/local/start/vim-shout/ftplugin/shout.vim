vim9script

if exists("b:did_ftplugin")
    finish
endif

b:did_ftplugin = 1

b:undo_ftplugin = 'exe "nunmap <buffer> <cr>"'
b:undo_ftplugin ..= '| exe "nunmap <buffer> <space><cr>"'
b:undo_ftplugin ..= '| exe "nunmap <buffer> <C-c>"'

import autoload 'shout.vim'

nnoremap <buffer> <cr> <scriptcmd>shout.OpenFile()<cr>
nnoremap <buffer> <space><cr> <scriptcmd>shout.OpenFile("tab")<cr>
nnoremap <buffer> <C-c> <scriptcmd>shout.Kill()<cr><C-c>
