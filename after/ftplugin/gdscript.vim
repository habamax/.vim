setlocal fdm=expr
setlocal tabstop=4

let b:foldchar = ''
let b:foldlines_padding = v:true

let b:select_sink = {}
let b:select_sink.godotscene = {"transform": {p, v -> fnameescape(p..v)}, "edit": "GodotRun %s"}
let b:select_runner = {}
let b:select_runner.godotscene = {"cmd": "rg --files --glob *.tscn"}



nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunFZF<CR>

nnoremap <buffer> <leader><leader>r :GodotRun<CR>
nnoremap <buffer> <leader><leader>c :GodotRunCurrent<CR>
nnoremap <buffer> <leader><leader>f :Select godotscene<CR>
nnoremap <buffer> <leader><leader>l :GodotRunLast<CR>

