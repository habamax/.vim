vim9script

import autoload 'popup.vim'
import autoload 'hlblink.vim'

def Preview()
    if !getqflist()[line('.') - 1].valid
        return
    endif
    exe "normal! \<CR>zz"
    hlblink.Line()
    wincmd p
enddef

nnoremap <buffer> i <scriptcmd>popup.ShowAtCursor(getqflist()[line('.') - 1].text)<CR>
nnoremap <buffer> o <scriptcmd>Preview()<CR>
