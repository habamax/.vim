vim9script

compiler go

setl shiftwidth=0
setl noexpandtab
setl formatprg=gofmt

if executable("goimports")
    # go install golang.org/x/tools/cmd/goimports@latest
    command! -buffer Fmt :%!goimports
else
    command! -buffer Fmt :%!gofmt
endif

nnoremap <buffer> <F5> :botright term ++rows=10 go run %<CR>

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("go doc " .. symbol))
enddef

nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>
