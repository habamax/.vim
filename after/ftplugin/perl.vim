vim9script

def RunPerl()
    update
    exe "Term perl" expand("%:p")
enddef

nnoremap <buffer> <F5> <scriptcmd>RunPerl()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
