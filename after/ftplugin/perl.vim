vim9script

def RunPerl()
    exe "Term perl" expand("%:p")
enddef

nnoremap <buffer> <F5> <cmd>update<cr><scriptcmd>RunPerl()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
