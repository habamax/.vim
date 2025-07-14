vim9script

if exists("b:did_after_ftplugin")
    finish
endif
b:did_after_ftplugin = 1

def RunPerl()
    exe "Sh perl" expand("%:p")
    win_gotoid(b:shout_initial_winid)
enddef

nnoremap <buffer> <F4> <scriptcmd>Shut<CR>
nnoremap <buffer> <F5> <scriptcmd>RunPerl()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F4>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
