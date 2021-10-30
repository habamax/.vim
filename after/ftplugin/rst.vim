if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl tw< sw< fo<"
else
    let b:undo_ftplugin = "setl tw< sw< fo<"
endif

compiler rst2html

" TODO: add it to undo ftplugin
command -buffer RSTViewHtml :call os#open(expand("%:p:r").'.html')
nnoremap <buffer> goh :RSTViewHtml<CR>

setlocal textwidth=79
setlocal formatoptions=tnc
setlocal shiftwidth=2
