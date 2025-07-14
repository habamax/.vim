vim9script

if exists("b:did_after_ftplugin")
    finish
endif
b:did_after_ftplugin = 1

nnoremap <buffer> <F4> <scriptcmd>Shut<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F4>"'
nnoremap <buffer> <F5> <scriptcmd>exe "Sh escript" expand("%:p")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
