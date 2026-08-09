vim9script

def Run()
    update
    exe "Term! perl" expand("%:p")
enddef

nnoremap <buffer> <F5> <scriptcmd>Run()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
