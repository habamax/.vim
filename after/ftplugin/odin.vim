vim9script

setl shiftwidth=0
setl noexpandtab tabstop=4

def RunOdin(file: bool = false)
    update
    var param = !file ? '.' : expand("%:t") .. ' -file'
    if exists("$WSL_DISTRO_NAME")
        exe $"Term! odin run {param} -thread-count:1"
    else
        exe $"Term! odin run {param}"
    endif
enddef

nnoremap <buffer> <F5> <scriptcmd>RunOdin()<CR>
nnoremap <buffer> <F6> <scriptcmd>RunOdin(1)<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F6>"'

import autoload 'popup.vim'
def Things()
    var things = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\v<\w*>\s*::\s*proc'
            line = substitute(line, '{.*$', '', '')
            things->add({text: $"{line}({nr})", linenr: nr})
        endif
    endfor
    popup.Select("Odin Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match Identifier '^\\s*\\k\\+\\ze\\s*::\\s*proc'")
            win_execute(winid, $"setl tabstop=4")
            hi def link PopupSelectLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'

if exists("g:loaded_lsp") && executable('ols')
    g:LspAddServer([{
        name: 'ols',
        filetype: ['odin'],
        path: 'ols',
    }])
    augroup LspSetup
        au!
        au User LspAttached lsp#SetupFT()
    augroup END
endif

