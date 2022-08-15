vim9script

setlocal formatlistpat=\\s*\\\\item\\s\\+

import autoload 'popup.vim'

def Strip(line: string): string
    var res = ""
    var states = [""]
    for ch in line
        var state = states[-1]
        if state == ""
            if ch == '\'
                states->add("cmdstart")
            else
                res ..= ch
            endif
        elseif state == 'cmdstart'
            if ch == '{' | states->add("cmdin") | endif
            if ch == ' '
                states->remove(-1)
                res ..= ch
            endif
        elseif state == 'cmdin'
            if ch == '\'
                states->add("cmdstart")
            elseif ch == '}'
                states->remove(-1)
            else
                res ..= ch
            endif
        endif
    endfor
    return res
enddef


def Extract(nr: number, name: string): string
    exe $":{nr}"
    normal! 0
    search($'\\{name}\s*{{', 'W', nr)
    silent normal! %yiB
    var res = @"->substitute("\\s*\n\\s*", " ", "g")
    return Strip(res)
enddef


def Toc()
    var view = winsaveview()
    var save_reg = @0
    var toc = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\\title\s*{'
            toc->add({text: $"{nr->Extract('title')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\section\s*{'
            toc->add({text: $"\t{nr->Extract('section')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\subsection\s*{'
            toc->add({text: $"\t\t{nr->Extract('subsection')} ({nr})",
                     linenr: nr})
        elseif line =~ '\\subsubsection\s*{'
            toc->add({text: $"\t\t\t{nr->Extract('subsubsection')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\paragraph\s*{'
            toc->add({text: $"\t\t\t\t{nr->Extract('paragraph')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\subparagraph\s*{'
            toc->add({text: $"\t\t\t\t\t{nr->Extract('subparagraph')} ({nr})",
                      linenr: nr})
        endif
    endfor
    @0 = save_reg
    winrestview(view)

    popup.FilterMenu("TOC", toc,
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
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>
