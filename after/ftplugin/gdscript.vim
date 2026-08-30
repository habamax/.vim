vim9script

import autoload 'popup.vim'
import autoload 'os.vim'

b:undo_ftplugin ..= ' | setl et< ts< sw< kp<'

var last_scene_run = ''

# Run last scene
def RunLast()
    if last_scene_run == ''
        echom "No scene was run yet!"
        return
    endif
    RunScene(last_scene_run)
enddef

# Run current scene
def RunCurrent()
    RunScene(expand("%:r") .. '.tscn')
enddef

# Run arbitrary scene
def RunScene(scene_name: string = "")
    if !exists('g:godot_executable')
        if executable('godot')
            g:godot_executable = 'godot'
        elseif executable('godot.exe')
            g:godot_executable = 'godot.exe'
        else
            echomsg 'Unable to find Godot executable, please specify g:godot_executable'
            return
        endif
    endif

    var godot_command = $'{g:godot_executable} {scene_name}'

    exe $"Term {godot_command}"

    last_scene_run = scene_name
enddef

def RunSceneFile()
    # TODO: implement using regular command
    var scenes = []
    if executable('fd')
        scenes = systemlist('fd --path-separator / --type f --hidden --follow --exclude .git --glob *.tscn')
    elseif executable('rg')
        scenes = systemlist('rg --path-separator / --files --hidden --glob !.git --glob *.tscn')
    else
        return
    endif
    popup.Select("Run scene", scenes,
        (res, key) => {
            RunScene(res.text)
        },
        (winid) => {
            win_execute(winid, 'syn match PopupSelectDirectorySubtle "^.*\(/\|\\\)"')
            hi def link PopupSelectDirectorySubtle Comment
        })
enddef

nnoremap <buffer> <F5> <scriptcmd>RunScene()<CR>
nnoremap <buffer> <F6> <scriptcmd>RunCurrent()<CR>
nnoremap <buffer> <F7> <scriptcmd>RunLast()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F6>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F7>"'

if exists("g:loaded_lsp") && executable('nc')
    g:LspAddServer([{
        name: 'gdscript',
        filetype: ['gdscript'],
        path: 'netcat',
        args: ['127.0.0.1', '6008'],
    }])

    lsp#Setup()
endif

if exists("g:loaded_lsp_vim") && executable('nc')
    lsp#Setup()
endif

command! -buffer Godot exe "silent !godot --editor %:p:r.tscn 2> /dev/null 1> /dev/null &" <bar> redraw!
