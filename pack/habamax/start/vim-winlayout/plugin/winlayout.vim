" nnoremap <F2> :call winlayout#save()<CR>
nnoremap <F3> :noautocmd call winlayout#restore(-1)<CR>
nnoremap <F4> :noautocmd call winlayout#restore(1)<CR>


augroup winlayout | au!
	au BufEnter * :call winlayout#save()
	au WinNew,QuitPre * :call winlayout#save()
	" au VimEnter,VimResized * :call winlayout#save()
	" au BufAdd,BufRead,BufDelete,WinNew,QuitPre * :call winlayout#save()
augroup end
