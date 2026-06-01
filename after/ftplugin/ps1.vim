vim9script

def RunPowershell()
    update
    exe "Term powershell -File" expand("%:p")
enddef

nnoremap <buffer> <F5> <scriptcmd>RunPowershell()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
