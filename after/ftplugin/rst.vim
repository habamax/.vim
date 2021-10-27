if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl tw< sw<"
else
    let b:undo_ftplugin = "setl tw< sw<"
endif

compiler rst2html
setlocal shiftwidth=2

" TODO: add it to undo ftplugin
command -buffer RSTViewHtml :call os#open(expand("%:p:r").'.html')
nnoremap <buffer> goh :RSTViewHtml<CR>

setlocal textwidth=79
