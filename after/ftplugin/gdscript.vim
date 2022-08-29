vim9script
import autoload 'popup.vim'
import autoload 'os.vim'

setlocal noet ts=4 sw=0


if exists(":DD") > 0
    setlocal keywordprg=:DD\ godot
endif


var last_scene_run = ''

# Run last scene
def RunGodotLast()
    if last_scene_run == ''
        echom "No scene was run yet!"
        return
    endif
    RunGodotScene(last_scene_run)
enddef


# Run current scene
def RunGodotCurrent()
    RunGodotScene(expand("%:r") .. '.tscn')
enddef



# Run arbitrary scene
def RunGodotScene(scene_name: string)
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
    os.Exe(godot_command)
    echom scene_name
    last_scene_run = scene_name
enddef


def RunScene()
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
            RunGodotScene(res.text)
        },
        (winid) => {
            win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
            hi def link FilterMenuDirectorySubtle Comment
        })
enddef

nnoremap <buffer> <space>r <scriptcmd>RunScene()<CR>
nnoremap <buffer> <F5> <scriptcmd>RunGodotScene("")<CR>
nnoremap <buffer> <F6> <scriptcmd>RunGodotCurrent()<CR>
nnoremap <buffer> <F7> <scriptcmd>RunGodotLast()<CR>


def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)\(func\|class\|signal\) \k\+('
                || line =~ 'if __name__ == "__main__":'
            things->add({text: $"{line} ({nr})", linenr: nr})
        endif
    endfor
    popup.FilterMenu("Py Things", things,
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
