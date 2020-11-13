" setlocal fdm=expr
setlocal tabstop=4

let b:foldchar = ''
let b:foldlines_padding = v:true

let b:select_info = {"godot": {}}
let b:select_info.godot.data = {"job": "rg --files --glob *.tscn"}
let b:select_info.godot.sink = {
            \ "transform": {_, v -> fnameescape(v)},
            \ "action": "GodotRun %s"
            \ }
let b:select_info.godot.highlight = {"DirectoryPrefix": ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}
let b:select_info.godot.prompt = "Run Godot Scene> "



nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>

nnoremap <buffer> <space><space>r :GodotRun<CR>
nnoremap <buffer> <space><space>c :GodotRunCurrent<CR>
nnoremap <buffer> <space><space>f :Select godot<CR>
nnoremap <buffer> <space><space>l :GodotRunLast<CR>

