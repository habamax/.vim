setlocal fdm=expr
setlocal tabstop=4

let b:foldchar = ''
let b:foldlines_padding = v:true

nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunFZF<CR>

nnoremap <buffer> <leader><leader>r :GodotRun<CR>
nnoremap <buffer> <leader><leader>c :GodotRunCurrent<CR>
nnoremap <buffer> <leader><leader>f :GodotRunFZF<CR>
nnoremap <buffer> <leader><leader>l :GodotRunLast<CR>
