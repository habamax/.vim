setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal smarttab
setlocal ff=unix

compiler adoc2pdf


" gf to open include files
setlocal includeexpr=substitute(v:fname,'include::\\([^[\\]]\\{-}\\)\\[.*\\]','\\1','g')

" open files
nnoremap <buffer> <leader>oh :silent !%:p:r.html<CR>

if has("win32")
	let b:browser = ":!start ".shellescape('C:\Program Files (x86)\Mozilla Firefox\firefox.exe')
else
	let b:browser = "firefox"
endif

nnoremap <buffer> <leader>oo :exe b:browser." ".expand("%:p")<CR>
nnoremap <buffer> <leader>op :exe b:browser." ".expand("%:p:r").".pdf"<CR>
nnoremap <buffer> <leader>oh :exe b:browser." ".expand("%:p:r").".html"<CR>

" compile
nnoremap <buffer> <leader>cc :make<CR>
nnoremap <buffer> <leader>ch :compiler adoc<CR>
nnoremap <buffer> <leader>cp :compiler adoc2pdf<CR>


fun! AsciiDocFoldExpr(line)
  if match(getline(a:line), '^=.*') >= 0
    return '>1'
  elseif match(getline(a:line), '^:.*:.*') >= 0
    return '2'
  else
    return '1'
  endif
endfun

setlocal foldexpr=AsciiDocFoldExpr(v:lnum)
setlocal foldmethod=expr
