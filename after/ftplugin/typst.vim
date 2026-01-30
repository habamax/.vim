vim9script

import autoload 'popup.vim'
import autoload 'os.vim'

&l:makeprg = $"typst compile --root={expand("~/docs")} {expand("%")}"
b:undo_ftplugin ..= ' | setl makeprg<'

def BuildPDF(watch: bool = false)
    if watch
        exe $"Term typst watch --root={expand("~/docs")} {expand("%:p")}"
    else
        exe "Make"
    endif
enddef

nnoremap <buffer> <F5> <cmd>update<cr><scriptcmd>BuildPDF()<cr>
nnoremap <buffer> <space><F5> <cmd>update<cr><scriptcmd>BuildPDF(true)<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space><F5>"'
nnoremap <buffer> <F3> <scriptcmd>os.Open(expand("%<") .. ".pdf")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space><F3>"'

def Toc()
    var toc = []
    var toc_num: list<number> = []
    var plvl = 0
    var lvl = 1
    var skip_fence = false
    for nr in range(1, line('$'))
        var line = getline(nr)
        var pline = getline(nr - 1)
        if line =~ '^```'
            skip_fence = !skip_fence
        endif
        if skip_fence
            continue
        endif
        if line =~ '^=\+\s\S\+'
            lvl = line->matchstr('^=\+')->len() - 1
            if lvl >= len(toc_num)
                for _ in range(lvl - len(toc_num) + 1)
                    toc_num->add(1)
                endfor
            else
                if lvl > plvl
                    toc_num[lvl] = 1
                else
                    toc_num[lvl] += 1
                endif
            endif
            toc->add({lvl: lvl, toc_num: toc_num[: lvl], text: line->trim(" ="), posttext: $' ({nr})', linenr: nr})
        endif
        plvl = lvl
    endfor

    var title = toc->reduce((acc, v) => v.lvl == 0 ? acc + 1 : acc, 0) == 1 ? 1 : 0

    for t in toc
        var toc_num_str = t.toc_num[title : ]->join('.')
        t.text = repeat("  ", t.lvl - title) .. $"{toc_num_str} {t.text}"
    endfor

    popup.Select("TOC", toc,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, 'syn match PopupSelectLineNr "(\d\+)$"')
            win_execute(winid, 'syn match PopupSelectSecNum "^\s*\(\d\+\.\)*\(\d\+\)"')
            hi link PopupSelectLineNr Comment
            hi link PopupSelectSecNum markdownH1
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>
