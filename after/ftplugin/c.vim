vim9script

setlocal commentstring=//%s
setlocal foldignore=#
b:undo_ftplugin ..= ' | setl commentstring< foldignore<'

g:c_no_curly_error = true

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
    var rx_func = '\v^\s*(\k+\_s+){1,}\k+'
    rx_func ..= '\s*\((\_s*[*_,[:alnum:]]{-}(\s*\/\/.*)?){-}\)'
    rx_func ..= '\s*(\/\/.*)?'
    rx_func ..= '\_s{-}\{\s*$'
    while search(rx_func, 'W') != 0
        if getline('.') =~ '^\s*else\s\+if\s*('
            continue
        endif
        var text = trim(getline('.'))->substitute('\s*\/\/.*$', '', '')
        var lnum = line('.')
        var shift = 0
        while text !~ '{\s*$' && (lnum + shift) < line('$')
            shift += 1
            if text !~ '(\s*$'
                text ..= " "
            endif
            text ..= trim(getline(lnum + shift)->substitute('\s\+', ' ', 'g'))
            text = text->substitute('\s*\/\/.*$', '', '')
        endwhile
        lnum = shift < 2 ? lnum : lnum + 1
        add(things, {text: trim(text, " {", 2) .. $" ({lnum})", lnum: lnum})
    endwhile
    popup.Select("C Things", things,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match PopupSelectFuncName '\\k\\+\\s*\\ze('")
            hi def link PopupSelectLineNr Comment
            hi def link PopupSelectFuncName Function
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
