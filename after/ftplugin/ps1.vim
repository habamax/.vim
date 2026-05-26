vim9script

def RunPowershell()
    exe "Term powershell -File" expand("%:p")
enddef

nnoremap <buffer> <F5> <cmd>update<cr><scriptcmd>RunPowershell()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
