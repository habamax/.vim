vim9script

compiler go

setl shiftwidth=0
setl noexpandtab
setl formatprg=gofmt

def Run()
    update
    exe "Term go run" expand("%:p")
enddef

nnoremap <buffer> <F5> <scriptcmd>Run()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("go doc " .. symbol))
enddef

nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>


# go install golang.org/x/tools/gopls@latest
if exists("g:loaded_lsp") && executable('gopls')
    g:LspAddServer([{
        name: 'gopls',
        filetype: ['go'],
        path: 'gopls',
    }])
    lsp#SetupFT()
endif
