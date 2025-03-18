vim9script

nnoremap <buffer> <F4> <scriptcmd>Shut<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F4>"'
nnoremap <buffer> <F5> <scriptcmd>exe "Sh escript" expand("%:p")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
