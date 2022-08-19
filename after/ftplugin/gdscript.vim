vim9script
import autoload 'popup.vim'

setlocal ts=4 sw=0


if exists(":DD") > 0
    setlocal keywordprg=:DD\ godot
endif

nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunLast<CR>

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
            exe $"GodotRun {res.text}"
        },
        (winid) => {
            win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
            hi def link FilterMenuDirectorySubtle Comment
        })
enddef

nnoremap <buffer> <space><space>r <scriptcmd>RunScene()<CR>


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
