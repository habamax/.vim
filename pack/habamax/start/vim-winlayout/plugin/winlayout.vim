" nnoremap <F2> :call winlayout#save()<CR>
nnoremap <F3> :call winlayout#restore(-1)<CR>
nnoremap <F4> :call winlayout#restore(1)<CR>


augroup winlayout | au!
	au BufEnter * :call winlayout#save()
	au WinNew,QuitPre * :call winlayout#save()
augroup end

command WinlayoutInspect call winlayout#inspect()
