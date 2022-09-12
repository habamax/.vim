vim9script
import autoload 'popup.vim'
import autoload 'os.vim'

b:undo_ftplugin ..= ' | setl et< ts< sw< kp<'

setlocal noet ts=4 sw=0

if exists(":DD") > 0
    setlocal keywordprg=:DD\ godot
endif


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
def RunScene(scene_name: string)
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
    os.ExeTerm(godot_command)
    last_scene_run = scene_name
enddef


def RunSelectedScene()
    var scenes = []
    if executable('fd')
        scenes = systemlist('fd --path-separator / --type f --hidden --follow --exclude .git --glob *.tscn')
    elseif executable('rg')
        scenes = systemlist('rg --path-separator / --files --hidden --glob !.git --glob *.tscn')
    else
        return
    endif
    popup.FilterMenu("Run scene", scenes,
        (res, key) => {
            RunScene(res.text)
        },
        (winid) => {
            win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
            hi def link FilterMenuDirectorySubtle Comment
        })
enddef

nnoremap <buffer> <space>r <scriptcmd>RunSelectedScene()<CR>
nnoremap <buffer> <F5> <scriptcmd>RunScene("")<CR>
nnoremap <buffer> <F6> <scriptcmd>RunCurrent()<CR>
nnoremap <buffer> <F7> <scriptcmd>RunLast()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>r"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F6>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F7>"'


def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)\(func\|class\|signal\) \k\+('
                || line =~ 'if __name__ == "__main__":'
            things->add({text: $"{line} ({nr})", linenr: nr})
        endif
    endfor
    popup.FilterMenu("GDScript Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            hi def link FilterMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'


def YCMPopupDoc()
    var response = youcompleteme#GetCommandResponse('GetHover')
    if response == '' | return | endif
    popup.ShowAtCursor(response->split('\n'))
enddef

if exists("g:loaded_youcompleteme")
    nnoremap <silent><buffer> K <scriptcmd>YCMPopupDoc()<CR>
    nnoremap <silent><buffer> gd <scriptcmd>YcmCompleter GoTo<CR>
    nnoremap <silent><buffer> <space>gr <scriptcmd>YcmCompleter GoToReferences<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>gr"'
endif
