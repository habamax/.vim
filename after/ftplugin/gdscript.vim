let b:select_info = {"godot": {}}
let b:select_info.godot.data = {"job": "rg --files --glob *.tscn"}
let b:select_info.godot.sink = {
            \ "transform": {_, v -> fnameescape(v)},
            \ "action": "GodotRun %s"
            \ }
let b:select_info.godot.highlight = {"DirectoryPrefix": ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}
let b:select_info.godot.prompt = "Run Godot Scene> "


if exists(":DD")
    setlocal keywordprg=:DD\ godot
endif


nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunLast<CR>

nnoremap <buffer> <space><space>r :Select godot<CR>

nnoremap <silent><buffer> <F2> :g#^func\s#silent! exe "norm zdzfii"<CR>
