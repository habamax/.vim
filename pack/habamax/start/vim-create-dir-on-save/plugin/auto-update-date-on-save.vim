" auto-update-date-on-save.vim - Create directories on file save
" Maintainer:   Maxim Kim <habamax@gmail.com>

if exists("g:loaded_auto_update_date_on_save") || &cp || v:version < 700
	finish
endif
let g:loaded_auto_update_date_on_save = 1

" for now it is only ISO date in the YYYY-MM-DD is updated found in the first
" 20 lines of the file
fun! s:auto_update_date_on_save()
	1,20s/\v\d{4}-\d{2}-\d{2}/\=strftime("%Y-%m-%d")
endfu


augroup auto_update_date_on_save
	au!
	au BufWritePre * call s:auto_update_date_on_save()
augroup end
