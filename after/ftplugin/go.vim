vim9script

compiler go

setl shiftwidth=0
setl noexpandtab
setl formatprg=gofmt
setl tabstop=4

def Run()
    update
    exe "Term! go run" expand("%:p")
enddef

nnoremap <buffer> <F5> <scriptcmd>Run()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
