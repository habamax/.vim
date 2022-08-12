vim9script

setlocal formatlistpat=\\s*\\\\item\\s\\+

import autoload 'popup.vim'
def Toc()
    var toc = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\\title\s*{'
            toc->add({text: line->matchstr('\\title\s*{\zs[^}]\+')->trim(' \') .. $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\section\s*{'
            toc->add({text: "\t" .. line->matchstr('\\section\s*{\zs[^}]\+')->trim(' \') .. $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\subsection\s*{'
            toc->add({text: "\t\t" .. line->matchstr('\\subsection\s*{\zs[^}]\+')->trim(' \') .. $" ({nr})",
                     linenr: nr})
        elseif line =~ '\\subsubsection\s*{'
            toc->add({text: "\t\t\t" .. line->matchstr('\\subsubsection\s*{\zs[^}]\+')->trim(' \') .. $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\paragraph\s*{'
            toc->add({text: "\t\t\t\t" .. line->matchstr('\\paragraph\s*{\zs[^}]\+')->trim(' \') .. $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\subparagraph\s*{'
            toc->add({text: "\t\t\t\t\t" .. line->matchstr('\\subparagraph\s*{\zs[^}]\+')->trim(' \') .. $" ({nr})",
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
