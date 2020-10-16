setlocal fdm=expr
setlocal tabstop=4

let b:foldchar = ''
let b:foldlines_padding = v:true

let b:select_runner = {"godotscene": {}}
let b:select_runner.godotscene.data = {"cmd": "rg --files --glob *.tscn"}
let b:select_runner.godotscene.sink = {"transform": {_, v -> fnameescape(v)}, "action": "GodotRun %s"}



nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>

nnoremap <buffer> <leader><leader>r :GodotRun<CR>
nnoremap <buffer> <leader><leader>c :GodotRunCurrent<CR>
nnoremap <buffer> <leader><leader>f :Select godotscene<CR>
nnoremap <buffer> <leader><leader>l :GodotRunLast<CR>

