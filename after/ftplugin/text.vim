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
        '\v^\s*(\d+.?\s+)?([[:upper:]]+[[:punct:][:digit:][:upper:][:punct:][:blank:]]+)+\s*$',
        1, '$')->foreach((i, v) => {
            v.text = $"{v.text->trim()} ({v.lnum})"
        })
    popup.Select("Toc", toc,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            hi def link PopupSelectLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
