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
    if exists(":QF") == 2
        exe "QF" godot_command
    elseif exists(":Sh") == 2
        exe "Sh" godot_command
        win_gotoid(b:shout_initial_winid)
    else
        os.ExeTerm(godot_command)
    endif
    last_scene_run = scene_name
enddef

def RunSceneFile()
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

nnoremap <buffer> <F4> <scriptcmd>Shut<CR>
nnoremap <buffer> <F5> <scriptcmd>RunScene()<CR>
nnoremap <buffer> <F6> <scriptcmd>RunCurrent()<CR>
nnoremap <buffer> <F7> <scriptcmd>RunLast()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F4>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F6>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F7>"'

def Things()
    var things = matchbufline(bufnr(),
        '\v^\s*(func|class|signal)\s+\k+.*$',
        1, '$')->foreach((_, v) => {
            v.text = v.text
            v.posttext = $" ({v.lnum})"
        })
    popup.Select("GDScript Things", things,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match PopupSelectFuncName '\\k\\+\\ze('")
            hi def link PopupSelectLineNr Comment
            hi def link PopupSelectFuncName Function
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'

if exists("g:loaded_lsp")
    import autoload 'lsp.vim'
    au User LspAttached lsp.SetupFT()
endif

command! -buffer Godot exe "silent !godot --editor %:p:r.tscn 2> /dev/null 1> /dev/null &" <bar> redraw!
