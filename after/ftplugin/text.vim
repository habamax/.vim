vim9script

if exists('b:undo_ftplugin')
    b:undo_ftplugin ..= "|setl cms< com< fo< flp< tw<"
else
    b:undo_ftplugin = "setl cms< com< fo< flp< tw<"
endif

setlocal comments=
setlocal commentstring=
setlocal formatoptions=tcqln
setlocal formatlistpat=^\\s*
setlocal formatlistpat+=[
setlocal formatlistpat+=\\[({]\\?
setlocal formatlistpat+=\\(
setlocal formatlistpat+=[0-9\ xX]\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=[a-zA-Z]
setlocal formatlistpat+=\\)
setlocal formatlistpat+=[\\]:.)}
setlocal formatlistpat+=]
setlocal formatlistpat+=\\s\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=^\\s*-\\s\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=^\\s*[*]\\+\\s\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=^\\s*[.]\\+\\s\\+

setlocal textwidth=80

import autoload "popup.vim"
def Toc()
    var toc = matchbufline(bufnr(),
        '\v^\s*(\u+[[:punct:][:digit:][:upper:][:punct:][:blank:]]+)+\s*$',
        1, '$')->foreach((i, v) => {
            v.text = $"{i + 1} {v.text} ({v.lnum})"
        })
    popup.FilterMenu("Toc", toc,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            win_execute(winid, 'syn match FilterMenuSecNum "^\s*\(\d\+\.\)*\(\d\+\)"')
            hi def link FilterMenuLineNr Comment
            hi def link FilterMenuSecNum Title
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
