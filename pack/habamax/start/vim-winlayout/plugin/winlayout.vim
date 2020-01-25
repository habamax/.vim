nnoremap <F2> :call winlayout#save()<CR>
nnoremap <F3> :noautocmd call winlayout#restore(-1)<CR>
nnoremap <F4> :noautocmd call winlayout#restore(1)<CR>


augroup winlayout | au!
	au BufReadPost * :call winlayout#save()
augroup end
