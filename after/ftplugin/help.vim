vim9script

b:undo_ftplugin ..= ' | exe "nunmap <buffer> <cr>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> o"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> u"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> J"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'

nnoremap <buffer> <cr> <C-]>
nnoremap <buffer> o <C-]>
nnoremap <buffer> u <C-t>
nnoremap <buffer> J <cmd>call search('\|[^\|[:space:]]\+\|', 'z')<cr>
nnoremap <buffer> K <cmd>call search('\|[^\|[:space:]]\+\|', 'zb')<cr>

import autoload 'popup.vim'

def Toc()
    var toc = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        var nline = getline(nr + 1)
        var pline = getline(prevnonblank(nr - 1))
        if line =~ '^\([=-]\)\1\+$' && !empty(nline) && empty(getline(nr - 1)) && nline !~ '^vim:'
            nline = nline->substitute('\(\(\s\{10,}\)\|\(\t\+\)\).*$', '', '')
            nline = nline->substitute('\*\([^*]\+\)\*', '\1', 'g')->trim('~ ')
            nline = nline->substitute('\t', '    ', 'g')->trim()
            if !empty(nline)
                toc->add({text: $'{nline} ({nr})', linenr: nr + 1})
            endif
        elseif line =~ '^\u[[:space:][:upper:]]\+\s*\*.*\*\s*$'
                && pline !~ '>\s*$'
                && pline !~ '^\([=-]\)\1\+$'
            line = line->substitute('\(\(\s\{10,}\)\|\(\t\+\)\).*$', '', '')
            line = line->substitute('\*\([^*]\+\)\*', '\1', 'g')->trim()
            toc->add({text: $"\t{line} ({nr})", linenr: nr})
        elseif line =~ '^\S\+.*\~\s*$' && line[0] != '<'
                && nline !~ '^\([=-]\)\1\+$'
                && line !~ '\t\t' && line !~ '\s\{8,}'
                && empty(getline(nr - 1))
            toc->add({text: $"\t\t{line->trim('~ ')} ({nr})", linenr: nr})
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
