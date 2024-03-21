vim9script

import autoload 'popup.vim'

def Things()
    var things = []
    var commentchars = split(&cms, "%s")[0]
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '{\{3}\s*$'
            line = matchstr(line, '^\s*' .. commentchars .. '\s*\zs.\{-}\ze\s*{\{3}\s*$')
            things->add({text: $'{line} ({nr})', linenr: nr})
        endif
    endfor

    popup.Select("Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, "setl ts=4 list")
            win_execute(winid, $"syn match PopupSelectMenuLineNr '(\\d\\+)$'")
            hi def link PopupSelectMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
