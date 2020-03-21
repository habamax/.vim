setl keywordprg=:help
setl foldenable 
setl foldmethod=marker
setl foldlevel=1
if !&readonly
	setlocal ff=unix
endif

let b:foldtext_strip_comments = v:true

" make line continuation `\` less indented (default is *3)
" let g:vim_indent_cont = shiftwidth() * 2
