setl shiftwidth=0
setl noexpandtab
setl formatprg=gofmt

if executable("goimports")
    " go install golang.org/x/tools/cmd/goimports@latest
    command! -buffer Fmt :%!goimports
else
    command! -buffer Fmt :%!gofmt
endif

if exists(":DD")
    setlocal keywordprg=:DD\ go
endif

" func! s:goDocPopup(keyword) abort
"     let winid = popup_atcursor('', {
" 		\ "title": 'go doc ' . a:keyword,
" 		\ "border": [],
" 		\ "borderchars": ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
" 		\ "padding": [],
" 		\ "mapping": 0,
" 		\})
"     let bufnr = winbufnr(winid)
"     call setbufline(bufnr, 1, systemlist("go doc " . a:keyword))
" endfunc

" nnoremap <buffer> K :call <SID>goDocPopup("")
