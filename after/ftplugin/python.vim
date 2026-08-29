vim9script

if executable('black')
    &l:formatprg = "black -q - 2>/dev/null"
elseif executable('yapf')
    # pip install yapf
    &l:formatprg = "yapf"
endif

setlocal foldignore=

b:undo_ftplugin ..= ' | setl foldignore< formatprg<'

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("python -m pydoc " .. symbol), (winid) => {
        setbufvar(winbufnr(winid), "&ft", "rst")
    })
enddef

def Run()
    update
    exe "Term! python" expand("%:p")
enddef

nnoremap <buffer> <F5> <scriptcmd>Run()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

if exists("g:loaded_lsp") && executable('pylsp')
    g:LspAddServer([{
        name: 'pylsp',
        filetype: ['python'],
        path: 'pylsp',
    }])
    lspft#Setup()
endif

if exists("g:loaded_lsp_vim") && executable('pylsp')
    lspft#Setup()
endif
