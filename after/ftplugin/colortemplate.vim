vim9script

import autoload 'popup.vim'

def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '^Background:'
            things->add({text: $'{line} ({nr})', linenr: nr})
        endif
    endfor

    popup.FilterMenu("Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, "setl ts=4 list")
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            hi def link FilterMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>

