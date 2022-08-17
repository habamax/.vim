vim9script
if executable('yapf')
    # pip install yapf
    command -buffer Fmt :%!yapf
    &l:formatprg = "yapf"
endif

setlocal foldignore=

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("python -m pydoc " .. symbol), (winid) => {
        setbufvar(winbufnr(winid), "&ft", "rst")
    })
enddef

nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>


def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)\(def\|class\) \k\+('
                || line =~ 'if __name__ == "__main__":'
            things->add({text: $"{line} ({nr})", linenr: nr})
        endif
    endfor
    popup.FilterMenu("Py Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            hi def link FilterMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
