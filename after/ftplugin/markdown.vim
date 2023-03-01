vim9script

setl commentstring=<!--%s-->

# header textobject
onoremap <buffer><silent> iP <scriptcmd>HeaderTextObj(true)<CR>
onoremap <buffer><silent> aP <scriptcmd>HeaderTextObj(false)<CR>
xnoremap <buffer><silent> iP <esc><scriptcmd>HeaderTextObj(true)<CR>
xnoremap <buffer><silent> aP <esc><scriptcmd>HeaderTextObj(false)<CR>

import autoload 'popup.vim'
def Toc()
    var toc = []
    var toc_num: list<number> = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '^#\+\s\S\+'
            var lvl = line->matchstr('^#\+')->len() - 1
            if lvl >= len(toc_num)
                for _ in range(lvl - len(toc_num) + 1)
                    toc_num->add(1)
                endfor
            else
                toc_num[lvl] += 1
            endif
            toc->add({lvl: lvl, toc_num: toc_num[: lvl], text: $'{line->trim(" #")} ({nr})', linenr: nr})
            continue
        endif
        var pline = getline(nr - 1)
        if line =~ '^=\+$' && pline =~ '^\S\+'
            if len(toc_num) < 1
                toc_num->add(1)
            else
                toc_num[0] += 1
            endif
            toc->add({lvl: 0, toc_num: toc_num[: 0], text: $'{pline} ({nr - 1})', linenr: nr - 1})
        elseif line =~ '^-\+$' && pline =~ '^\S\+'
            if len(toc_num) < 2
                toc_num->add(1)
            else
                toc_num[1] += 1
            endif
            var toc_num_str = toc_num[: 1]->join('.')
            toc->add({lvl: 1, toc_num: toc_num[: 1], text: $'{pline} ({nr - 1})', linenr: nr - 1})
        endif
    endfor

    var title = toc->reduce((acc, v) => v.lvl == 0 ? acc + 1 : acc, 0) == 1 ? 1 : 0

    for t in toc
        var toc_num_str = t.toc_num[title : ]->join('.')
        t.text = repeat("  ", t.lvl - title) .. $"{toc_num_str} {t.text}"
    endfor

    popup.FilterMenu("TOC", toc,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, 'syn match FilterMenuLineNr "(\d\+)$"')
            win_execute(winid, 'syn match FilterMenuSecNum "^\s*\(\d\+\.\)*\(\d\+\)"')
            hi def link FilterMenuLineNr Comment
            hi def link FilterMenuSecNum Title
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>


# Markdown header text object
# * inner object is the text between prev section header(excluded) and the next
#   section of the same level(excluded) or end of file.
# * an object is the text between prev section header(included) and the next section of the same
#   level(excluded) or end of file.
def HeaderTextObj(inner: bool)
    var lnum_start = search('^#\+\s\+[^[:space:]=]', "ncbW")
    if lnum_start > 0
        var lvlheader = matchstr(getline(lnum_start), '^#\+')
        var lnum_end = search('^#\{1,' .. len(lvlheader) .. '}\s', "nW")
        if lnum_end == 0
            lnum_end = search('\%$', 'cnW')
        else
            lnum_end -= 1
        endif
        if inner && getline(lnum_start + 1) !~ '^#\+\s\+[^[:space:]=]'
            lnum_start += 1
        endif

        echom lnum_start lnum_end
        exe $":{lnum_end}"
        normal! V
        exe $":{lnum_start}"
    endif
enddef
