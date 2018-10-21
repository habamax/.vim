setl softtabstop=4
setl shiftwidth=4
setl expandtab
setl ff=unix
setl comments=n:*,n:.,n:-

compiler adoc

let &commentstring="// %s"

" gf to open include files
setlocal includeexpr=substitute(v:fname,'include::\\(.\\{-}\\)\\[.*','\\1','g')

" open files
if has("win32")
	let b:opener = ":!start"
elseif has("osx")
	let b:opener = ":!open"
elseif has("win32unix")
	let b:opener = ":!start"
else
	let b:opener = ":!firefox"
endif

nnoremap <buffer> <leader>oo :exe b:opener." ".expand("%:p")<CR>
nnoremap <buffer> <leader>op :exe b:opener." ".expand("%:p:r").".pdf"<CR>
nnoremap <buffer> <leader>oh :exe b:opener." ".expand("%:p:r").".html"<CR>
nnoremap <buffer> <leader>ox :exe b:opener." ".expand("%:p:r").".docx"<CR>

" change compiler and compile
nnoremap <buffer> <leader>ch :compiler adoc<CR>:make<CR>
nnoremap <buffer> <leader>cp :compiler adoc2pdf<CR>:make<CR>
nnoremap <buffer> <leader>cx :compiler adoc2docx<CR>:make<CR>

fun! AsciiDocFoldExpr(line)
	let line = getline(a:line)
	" I think that top level heading AKA title should have the same level
	" as level 2.
	if match(line, '^=[[:space:]].\+') >= 0
		return '>1'
	elseif match(line, '^==[[:space:]].\+') >= 0
		return '>1'
	elseif match(line, '^===[[:space:]].\+') >= 0
		return '>2'
	elseif match(line, '^====[[:space:]].\+') >= 0
		return '>3'
	elseif match(line, '^=====[[:space:]].\+') >= 0
		return '>4'
	elseif match(line, '^======[[:space:]].\+') >= 0
		return '>5'
	elseif match(line, '^=======[[:space:]].\+') >= 0
		return '>6'
	else
		return '='
	endif
endfun

setlocal foldexpr=AsciiDocFoldExpr(v:lnum)
setlocal foldmethod=expr


hi asciidocOneLineTitle gui=bold cterm=bold
hi asciidocTwoLineTitle gui=bold cterm=bold
hi! link asciidocLiteralParagraph Normal
hi! link asciidocListBullet TypeDef
hi! link asciidocListNumber TypeDef
