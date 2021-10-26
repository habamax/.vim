if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl flp< tw< sw<"
else
    let b:undo_ftplugin = "setl flp< tw< sw<"
endif

compiler rst2html
setlocal shiftwidth=2

" TODO: add it to undo ftplugin
command -buffer RSTViewHtml :call os#open(expand("%:p:r").'.html')
nnoremap <buffer> goh :RSTViewHtml<CR>

setlocal textwidth=79

setlocal formatlistpat=^\\s*
setlocal formatlistpat+=[
setlocal formatlistpat+=\\[({]\\?
setlocal formatlistpat+=\\(
setlocal formatlistpat+=[#0-9\ xX]\\+
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

