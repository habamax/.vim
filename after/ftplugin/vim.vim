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
    var commentchars = split(&cms, "%s")[0]
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)def \k\+('
        || line =~ '\(^\|\s\)fu\%[nction]!\?\s\+\([sgl]:\)\?\k\+('
        || line =~ '^\s*com\%[mand]!\?\s\+\S\+'
        || line =~ '^\s*aug\%[roup]\s\+\S\+' && line !~ '\c^\s*aug\%[roup] end\s*$'
            if line =~ '^\s*com\%[mand]!\?\s\+\S\+'
                line = line->substitute(' -\(range\|count\|nargs\)\(=.\)\?', '', 'g')
                line = line->substitute(' -\(bang\|buffer\)', '', '')
                line = line->substitute(' -complete=\S\+', '', '')
                line = line->substitute('^\s*com\%[mand]!\?\s\+\S\+\zs.*', '', '')
                line = line->substitute('^\s*com\%[mand]!\?\s\+', '', '')
            endif
            things->add({text: $"{line} ({nr})", linenr: nr})
        endif
        if line =~ '{\{3}\s*$'
            line = matchstr(line, '^\s*' .. commentchars .. '\s*\zs.\{-}\ze\s*{\{3}\s*$')
            things->add({text: $'{line} ({nr})', linenr: nr})
        endif
    endfor
    popup.Select("Vim Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match PopupSelectFuncName '\\k\\+\\ze('")
            hi def link PopupSelectLineNr Comment
            hi def link PopupSelectFuncName Function
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>

nnoremap <buffer> <F5> :source<CR>

iab <buffer> v9 vim9script<C-R>=misc#Eatchar('\s')<CR>

def SentenceForward()
    var rx = '\v<((else(if)?)|(end(if|def|for|while|func|try)))>'
    var res = search(rx, 'e')
    var stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    while res != 0 && (!empty(stx) && stx[-1] =~ 'Comment\|String')
        res = search(rx, 'e')
        stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endwhile
enddef

def SentenceBackward()
    var rxDef = '<((export\s+)?def\s+\k+\s*\()'
    var rxFunc = '(<(^\s*func\s+\k+\s*\())'
    var rxRest = '(<(try|finally|catch|if|else|elseif|for|while)>)'
    var rx = $'\v{rxDef}|{rxFunc}|{rxRest}'
    var res = search(rx, 'b')
    var stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    while res != 0 && (!empty(stx) && stx[-1] =~ 'Comment\|String')
        res = search(rx, 'b')
        stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endwhile
enddef

nnoremap <buffer> ) <scriptcmd>SentenceForward()<cr>
nnoremap <buffer> ( <scriptcmd>SentenceBackward()<cr>
