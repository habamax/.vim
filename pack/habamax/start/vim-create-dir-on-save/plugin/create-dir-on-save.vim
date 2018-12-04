" create-dir-on-save.vim - Create directories on file save
" Maintainer:   Maxim Kim <habamax@gmail.com>

if exists("g:loaded_create_dir_on_save") || &cp || v:version < 700
	finish
endif
let g:loaded_create_dir_on_save = 1

" Create dirs on file save
fu! s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfu

augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call <sid>MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

