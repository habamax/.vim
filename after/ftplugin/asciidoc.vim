setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal ff=unix

compiler adoc2pdf

let &commentstring="// %s"

" gf to open include files
setlocal includeexpr=substitute(v:fname,'include::\\(.\\{-}\\)\\[.*','\\1','g')

" open files
if has("win32")
	let b:opener = ":!start ".shellescape('C:\Program Files (x86)\Mozilla Firefox\firefox.exe')
elseif has("osx")
	let b:opener = ":!open -a firefox"
elseif has("win32unix")
	let b:opener = ":!start ".shellescape('/c/Program Files (x86)/Mozilla Firefox/firefox.exe')
else
	let b:opener = ":!firefox"
endif

nnoremap <buffer> <leader>oo :exe b:opener." ".expand("%:p")<CR>
nnoremap <buffer> <leader>op :exe b:opener." ".expand("%:p:r").".pdf"<CR>
nnoremap <buffer> <leader>oh :exe b:opener." ".expand("%:p:r").".html"<CR>

" compile
nnoremap <buffer> <leader>cc :make<CR>

" change compiler
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


inorea <buffer> <<< «
inorea <buffer> >>> »

inorea <buffer> options: :author: Максим Ким
			\<CR>:experimental:
			\<CR>:toc: left
			\<CR>:toclevels: 3
			\<CR>:icons: font
			\<CR>:sectnums:
			\<CR>:source-highlighter: coderay
			\<CR>:caution-caption: Предостережение
			\<CR>:important-caption: Важно
			\<CR>:note-caption: Замечание
			\<CR>:tip-caption: Подсказка
			\<CR>:warning-caption: Внимание
			\<CR>:figure-caption: Рисунок
			\<CR>:table-caption: Таблица
			\<CR>:example-caption: Пример
			\<CR>:toc-title: Содержание
			\<CR>:appendix-caption: Приложение
			\<CR>:last-update-label: Обновлено
			\<CR>:pdf-style: default
			\<CR>:revdate: <C-R>=strftime("%Y-%m-%d")<CR>

nnoremap <buffer> <leader>mt :call Asciidoc_convert_admonition()<CR>

fun! Asciidoc_convert_admonition()
	let linenr = line('.')
	let savelinenr = linenr
	" processing 
	" NOTE: style of admonitions
	let matches = matchlist(getline(linenr), '\v^(NOTE|TIP|CAUTION|WARNING|IMPORTANT): (.*)')
	if len(matches) != 0
		call setline(linenr, '['.matches[1].']')
		call append(linenr, '--')
		let linenr += 1
		call append(linenr, matches[2])
		" it could be multilined, so skip non-empty lines
		while getline(linenr) !~ '^\s*$'
			let linenr += 1
		endwhile
		" now close the admonition block
		call append(linenr-1, '--')
	else
		let matches = matchlist(getline(linenr), '\v^\[(NOTE|TIP|CAUTION|WARNING|IMPORTANT)\]\s*$')
		if len(matches) != 0
			if getline(linenr+1) == '--'
				call setline(linenr, matches[1].":")
				.+1del _
				.-1join
				while getline(linenr) != '--' && linenr < line('$')
					if getline(linenr) =~ '^\s*$'
						exe linenr."join"
					else
						let linenr += 1
					endif
				endwhile
				if getline(linenr) == '--'
					exe linenr."del _"
					exe savelinenr
				endif
			endif
		endif
	endif
endfun

