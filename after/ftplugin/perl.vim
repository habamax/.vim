vim9script

nnoremap <buffer> <F5> <scriptcmd>exe "Sh perl" expand("%:p")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

