vim9script

b:undo_ftplugin ..= ' | exe "nunmap <buffer> <cr>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> o"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> u"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> J"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'

nnoremap <buffer> <cr> <C-]>
nnoremap <buffer> o <C-]>
nnoremap <buffer> u <C-t>
nnoremap <buffer> . <cmd>call search('\|[^\|[:space:]]\+\|', '')<cr>
nnoremap <buffer> , <cmd>call search('\|[^\|[:space:]]\+\|', 'b')<cr>
