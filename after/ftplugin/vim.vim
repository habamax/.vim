vim9script

setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

def Fold()
    silent! norm! zf/^enddef/e
enddef

import autoload 'popup.vim'
def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\<def \k\+(' || line =~ '\<fu\%[nction]!\?\s\+\([sgl]:\)\?\k\+('
            things->add({text: $"{line} ({nr})", linenr: nr})
        endif
    endfor
    popup.FilterMenu("Vim Things", things,
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

nnoremap <silent><buffer> <F2> :g#^def\s#silent! exe "norm! zd" \| call <sid>Fold()<CR>
nnoremap <buffer> <F5> :source<CR>
