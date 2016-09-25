compiler adoc2pdf

" open files
nnoremap <buffer> <leader>mfh :silent !%:p:r.html<CR>

if has("win32")
	let b:browser = ":!start ".shellescape('C:\Program Files (x86)\Mozilla Firefox\firefox.exe')
else
	let b:browser = "firefox"
endif

nnoremap <buffer> <leader>mfo :exe b:browser." ".expand("%:p")<CR>
nnoremap <buffer> <leader>mfp :exe b:browser." ".expand("%:p:r").".pdf"<CR>

" compile
nnoremap <buffer> <leader>mcc :make<CR>

" abbreviations
inorea adoc AsciiDoc
