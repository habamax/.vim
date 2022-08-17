vim9script

setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

import autoload 'popup.vim'
def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)def \k\+('
        || line =~ '\(^\|\s\)fu\%[nction]!\?\s\+\([sgl]:\)\?\k\+('
        || line =~ '^\s*com\%[mand]!\?\s\+\S\+'
        || line =~ '^\s*aug\%[roup]\s\+\S\+' && line !~ '\c^\s*aug\%[roup] end\s*$'
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

nnoremap <buffer> <F5> :source<CR>

iab <buffer> v9 vim9script
