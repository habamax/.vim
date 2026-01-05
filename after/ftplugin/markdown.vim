vim9script

import autoload 'popup.vim'

setl commentstring=<!--%s-->

compiler markdown_html

nnoremap <buffer> <F5> :up<CR>:Make<CR>

# header textobject
onoremap <buffer><silent> iP <scriptcmd>HeaderTextObj(true)<CR>
onoremap <buffer><silent> aP <scriptcmd>HeaderTextObj(false)<CR>
xnoremap <buffer><silent> iP <esc><scriptcmd>HeaderTextObj(true)<CR>
xnoremap <buffer><silent> aP <esc><scriptcmd>HeaderTextObj(false)<CR>


inorea <buffer> no! > [!NOTE]
inorea <buffer> ti! > [!TIP]
inorea <buffer> im! > [!IMPORTANT]
inorea <buffer> wa! > [!WARNING]
inorea <buffer> ca! > [!CAUTION]

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

        exe $":{lnum_end}"
        normal! V
        exe $":{lnum_start}"
    endif
enddef

def FindSection(dir: string = '')
    search('\%(^#\{1,5\}\s\+\S\|^\S.*\n^[=-]\+$\)', $'{dir}sW')
    var mdsyn = synstack(line('.'), 1)->map('synIDattr(v:val, "name")')
    while mdsyn[0] =~ '^markdown\(CodeBlock\|Highlight\)'
        search('\%(^#\{1,5\}\s\+\S\|^\S.*\n^[=-]\+$\)', $'{dir}sW')
        mdsyn = synstack(line('.'), 1)->map('synIDattr(v:val, "name")')
    endwhile
    normal! zz
enddef

def SectionNav(dir: string = '')
    FindSection(dir)
    var winid = bufwinid(bufnr())
    var commands = [
        {text: "Sections"},
        {text: "Next", key: "j", cmd: (_) => {
            FindSection()
        }},
        {text: "Prev", key: "k", cmd: (_) => {
            FindSection('b')
        }},
    ]
    popup.Commands(commands)
enddef
nnoremap <buffer> <space>j <scriptcmd>SectionNav()<CR>
nnoremap <buffer> <space>k <scriptcmd>SectionNav('b')<CR>

def Toc()
    var toc = []
    var toc_num: list<number> = []
    var plvl = 0
    var lvl = 1
    var skip_fence = false
    var skip_yaml = false
    for nr in range(1, line('$'))
        var line = getline(nr)
        var pline = getline(nr - 1)
        if line =~ '^```'
            skip_fence = !skip_fence
        endif
        if line =~ '^---' && nr == 1
            skip_yaml = true
        elseif line =~ '^---' && skip_yaml
            skip_yaml = false
            continue
        endif
        if skip_fence || skip_yaml
            continue
        endif
        if line =~ '^#\+\s\S\+'
            lvl = line->matchstr('^#\+')->len() - 1
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
            toc->add({lvl: lvl, toc_num: toc_num[: lvl], text: line->trim(" #"), posttext: $' ({nr})', linenr: nr})
        elseif line =~ '^=\+$' && pline =~ '^\S\+'
            lvl = 1
            if len(toc_num) < 1
                toc_num->add(1)
            else
                if lvl > plvl
                    toc_num[0] = 1
                else
                    toc_num[0] += 1
                endif
            endif
            toc->add({lvl: 0, toc_num: toc_num[: 0], text: pline, posttext: $' ({nr - 1})', linenr: nr - 1})
        elseif line =~ '^-\+$' && pline =~ '^\S\+'
            lvl = 2
            if len(toc_num) < 2
                toc_num->add(1)
            else
                if lvl > plvl
                    toc_num[1] = 1
                else
                    toc_num[1] += 1
                endif
            endif
            var toc_num_str = toc_num[: 1]->join('.')
            toc->add({lvl: 1, toc_num: toc_num[: 1], text: pline, posttext: $' ({nr - 1})',  linenr: nr - 1})
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

def HlCheckmark()
    exe 'syn match mdCheckbox /\%(' .. &l:formatlistpat .. '\)\@<=\[[xX ]\]/ containedin=TOP'
    hi link mdCheckbox MarkdownListMarker
enddef

augroup checkmark | au!
    au Syntax markdown call HlCheckmark()
    au Colorscheme * call HlCheckmark()
augroup END
