vim9script

setlocal commentstring=//%s

def Make()
    if filereadable("Makefile")
        Sh make
    else
        var fname = expand("%:p:r")
        exe $"Sh make {fname} && chmod +x {fname} && {fname}"
    endif
enddef

nnoremap <buffer><F5> <scriptcmd>Make()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

import autoload 'popup.vim'
def Things()
    var view = winsaveview()
    defer winrestview(view)
    var things = []
    :1
    while search('\v^\s*(\k+\_s+){1,}\k+\((\_s*[*_,[:alnum:]]{-}){-}\)\_s{-}\{\s*$', 'W') != 0
        var text = trim(getline('.'))
        var lnum = line('.')
        var shift = 0
        while text !~ '{\s*$' && (lnum + shift) < line('$')
            shift += 1
            if text !~ '(\s*$'
                text ..= " "
            endif
            text ..= trim(getline(lnum + shift)->substitute('\s\+', ' ', 'g'))
        endwhile
        lnum = shift < 2 ? lnum : lnum + 1
        add(things, {text: trim(text, " {", 2) .. $" ({lnum})", lnum: lnum})
    endwhile
    popup.FilterMenu("C Things", things,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match FilterMenuFuncName '\\k\\+\\ze('")
            hi def link FilterMenuLineNr Comment
            hi def link FilterMenuFuncName Function
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'

if exists("g:loaded_lsp")
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    b:undo_ftplugin ..= ' | setl keywordprg<'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
endif
