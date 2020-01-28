if exists("g:loaded_winlayout") || v:version < 800
	finish
endif
let g:loaded_winlayout = 1

augroup winlayout | au!
	au BufEnter * :call winlayout#save()
	au WinNew,QuitPre * :call winlayout#save()
augroup end

command WinlayoutInspect call winlayout#inspect()

nnoremap <Plug>(WinlayoutBackward) :call winlayout#restore(-1)<CR>
nnoremap <Plug>(WinlayoutForward) :call winlayout#restore(1)<CR>


