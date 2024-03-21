vim9script

setl shiftwidth=0
setl noexpandtab
setl tabstop=4

nnoremap <buffer> <F5> <scriptcmd>Sh odin run .<CR><scriptcmd>wincmd p<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

import autoload 'popup.vim'
def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\v<\w*>\s*::\s*proc'
            line = substitute(line, '{.*$', '', '')
            things->add({text: $"{line}({nr})", linenr: nr})
        endif
    endfor
    popup.Select("Odin Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match Identifier '^\\s*\\k\\+\\ze\\s*::\\s*proc'")
            win_execute(winid, $"setl tabstop=4")
            hi def link PopupSelectLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
