vim9script

if executable('black')
    &l:formatprg = "black -q - 2>/dev/null"
elseif executable('yapf')
    # pip install yapf
    &l:formatprg = "yapf"
endif

setlocal foldignore=

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("python -m pydoc " .. symbol), (winid) => {
        setbufvar(winbufnr(winid), "&ft", "rst")
    })
enddef
def YCMPopupDoc()
    var response = youcompleteme#GetCommandResponse('GetDoc')
    if response == '' | return | endif
    popup.ShowAtCursor(response->split('\n'))
enddef


if exists("g:loaded_youcompleteme")
    nnoremap <silent><buffer> K <scriptcmd>YCMPopupDoc()<CR>
    nnoremap <silent><buffer> gd <scriptcmd>YcmCompleter GoTo<CR>
else
    nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
    xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>
endif


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
