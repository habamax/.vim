if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl tw< sw< fo<"
else
    let b:undo_ftplugin = "setl tw< sw< fo<"
endif

compiler rst2html

" TODO: add it to undo ftplugin
command -buffer RSTViewHtml :call os#open(expand("%:p:r").'.html')
nnoremap <buffer> goh :RSTViewHtml<CR>

command -buffer -nargs=? -complete=locale RSTHtml call s:rst2html(<f-args>)

func! s:rst2html(...) abort
    if !empty(a:000)
        let b:rst2html_opts = g:rst2html_opts . " --language=" . a:1
    else
        let b:rst2html_opts = g:rst2html_opts
    endif
    compiler rst2html
    if exists(":Make")
        Make
    else
        make
    endif
endfunc

setlocal textwidth=79
setlocal formatoptions=tnc
setlocal shiftwidth=2

augroup checkmark | au!
    au Syntax rst syn match rstCheckMark /✓\(\s*\d\{4}-\d\d-\d\d:\)\?/ contains=rstCheckMarkDate
    au Syntax rst syn match rstCheckMarkDate /\d\{4}-\d\d-\d\d:/ contained
    au Syntax rst hi link rstCheckMark Function
    au Syntax rst hi link rstCheckMarkDate Special
augroup END
