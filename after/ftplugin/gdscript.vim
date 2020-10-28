setlocal fdm=expr
setlocal tabstop=4

let b:foldchar = ''
let b:foldlines_padding = v:true

let b:select_info = {"godotscene": {}}
let b:select_info.godotscene.data = {"cmd": "rg --files --glob *.tscn"}
let b:select_info.godotscene.sink = {"transform": {_, v -> fnameescape(v)}, "action": "GodotRun %s"}



nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>

nnoremap <buffer> <space><space>r :GodotRun<CR>
nnoremap <buffer> <space><space>c :GodotRunCurrent<CR>
nnoremap <buffer> <space><space>f :Select godotscene<CR>
nnoremap <buffer> <space><space>l :GodotRunLast<CR>

