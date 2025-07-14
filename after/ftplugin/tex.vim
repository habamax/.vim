vim9script

if exists("b:did_after_ftplugin")
    finish
endif
b:did_after_ftplugin = 1

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
    search($'\\{name}\*\?\s*{{', 'W', nr)
    silent normal! %yiB
    var res = @"->substitute("\\s*\n\\s*", " ", "g")
    return Strip(res)
enddef

def Toc()
    var view = winsaveview()
    defer winrestview(view)
    var save_reg = @0
    var toc = []
    var toc_num = {section: 0, subsection: 0, subsubsection: 0, paragraph: 0, subparagraph: 0}
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\\title\*\?\s*{'
            toc->add({text: nr->Extract('title'), posttext: $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\section\*\?\s*{'
            toc_num.section += 1
            toc_num.subsection = 0
            toc_num.subsubsection = 0
            toc_num.subsubsection = 0
            toc_num.paragraph = 0
            toc_num.subparagraph = 0
            var prefix = $"{toc_num.section} "
            toc->add({text: $"{prefix}{nr->Extract('section')}", posttext: $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\subsection\*\?\s*{'
            toc_num.subsection += 1
            toc_num.subsubsection = 0
            toc_num.paragraph = 0
            toc_num.subparagraph = 0
            var prefix = $"{repeat('  ', 1)}{toc_num.section}.{toc_num.subsection} "
            toc->add({text: $"{prefix}{nr->Extract('subsection')}", posttext: $" ({nr})",
                     linenr: nr})
        elseif line =~ '\\subsubsection\*\?\s*{'
            toc_num.subsubsection += 1
            toc_num.paragraph = 0
            toc_num.subparagraph = 0
            var prefix = $"{repeat('  ', 2)}{toc_num.section}.{toc_num.subsection}.{toc_num.subsubsection} "
            toc->add({text: $"{prefix}{nr->Extract('subsubsection')}", posttext: $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\paragraph\*\?\s*{'
            toc_num.paragraph += 1
            toc_num.subparagraph = 0
            var prefix = $"{repeat('  ', 3)}{toc_num.section}.{toc_num.subsection}.{toc_num.subsubsection}.{toc_num.paragraph} "
            toc->add({text: $"{prefix}{nr->Extract('paragraph')}", posttext: $" ({nr})",
                      linenr: nr})
        elseif line =~ '\\subparagraph\*\?\s*{'
            toc_num.subparagraph += 1
            var prefix = $"{repeat('  ', 4)}{toc_num.section}.{toc_num.subsection}.{toc_num.subsubsection}.{toc_num.paragraph}.{toc_num.subparagraph} "
            toc->add({text: $"{prefix}{nr->Extract('subparagraph')}", posttext: $" ({nr})",
                      linenr: nr})
        endif
    endfor
    @0 = save_reg

    popup.Select("TOC", toc,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, 'syn match PopupSelectMenuLineNr "(\d\+)$"')
            win_execute(winid, 'syn match PopupSelectMenuSecNum "^\s*\(\d\+\.\)*\(\d\+\)"')
            hi def link PopupSelectMenuLineNr Comment
            hi def link PopupSelectMenuSecNum Title
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>


nnoremap <buffer> <F4> <scriptcmd>Shut<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F4>"'
nnoremap <buffer> <F5> <scriptcmd>exe "Sh latexmk -pvc" expand("%:p")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
nnoremap <buffer> <F6> <scriptcmd>exe "Sh latexmk " expand("%:p")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F6>"'
nnoremap <buffer> <F8> <scriptcmd>exe "Sh latexmk -c" expand("%:p")<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F8>"'
