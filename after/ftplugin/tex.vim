vim9script

setlocal formatlistpat=\\s*\\\\item\\s\\+

import autoload 'popup.vim'
def Toc()
    def Strip(line: string, name: string): string
        var res = line->matchstr($'\\{name}\s*{{\zs.*\ze}}')
        var emb = res->matchstr('\\\zs\a\+\ze\s*{.*}')
        if !empty(emb)
            return Strip(res, emb)
        else
            return res
        endif
    enddef
    var toc = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\\title\s*{'
            toc->add({text: $"{line->Strip('title')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\section\s*{'
            toc->add({text: $"\t{line->Strip('section')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\subsection\s*{'
            toc->add({text: $"\t\t{line->Strip('subsection')} ({nr})",
                     linenr: nr})
        elseif line =~ '\\subsubsection\s*{'
            toc->add({text: $"\t\t\t{line->Strip('subsubsection')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\paragraph\s*{'
            toc->add({text: $"\t\t\t\t{line->Strip('paragraph')} ({nr})",
                      linenr: nr})
        elseif line =~ '\\subparagraph\s*{'
            toc->add({text: $"\t\t\t\t\t{line->Strip('subparagraph')} ({nr})",
                      linenr: nr})
        endif
    endfor

    popup.FilterMenu("TOC", toc,
        (res, key) => {
            exe $":{res.linenr}"
        },
        (winid) => {
            win_execute(winid, "setl ts=4 list")
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            hi def link FilterMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>
