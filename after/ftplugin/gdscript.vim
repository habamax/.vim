setlocal ts=4 sw=0


if exists(":DD")
    setlocal keywordprg=:DD\ godot
endif

nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunLast<CR>

nnoremap <buffer> <space><space>r :Select godot<CR>

nnoremap <silent><buffer> <F2> :g#^func\s#silent! exe "norm zdzfii"<CR>
