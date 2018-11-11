setl keywordprg=:help
setl foldenable 
setl foldmethod=marker
setl foldlevel=1
if !&readonly
	setlocal ff=unix
endif
