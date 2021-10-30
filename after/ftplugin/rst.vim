if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl tw< sw< fo<"
else
    let b:undo_ftplugin = "setl tw< sw< fo<"
endif

compiler rst2html

" TODO: add it to undo ftplugin
command -buffer RSTViewHtml :call os#open(expand("%:p:r").'.html')
nnoremap <buffer> goh :RSTViewHtml<CR>

command -buffer RSTHtmlRU :let b:rst2html_opts = g:rst2html_opts . " --language=ru" | compiler rst2html | Make
command -buffer RSTHtml :let b:rst2html_opts = g:rst2html_opts | compiler rst2html | Make

setlocal textwidth=79
setlocal formatoptions=tnc
setlocal shiftwidth=2
