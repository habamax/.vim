setlocal fdm=expr
setlocal noexpandtab tabstop=4

let b:foldchar = ''
let b:foldlines_padding = v:true

nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunFZF<CR>

nnoremap <buffer> <leader>mr :GodotRun<CR>
nnoremap <buffer> <leader>mm :GodotRunCurrent<CR>
nnoremap <buffer> <leader>mf :GodotRunFZF<CR>
