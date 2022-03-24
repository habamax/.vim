vim9script
if executable('yapf')
    # pip install yapf
    command -buffer Fmt :%!yapf
    &l:formatprg = "yapf"
endif

setlocal foldignore=

def PopupHelp(symbol: string)
    popup#ShowAtCursor(systemlist("python -m pydoc " .. symbol))
enddef

nnoremap <silent><buffer> K :call <SID>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y:call <SID>PopupHelp(@@)<CR>
