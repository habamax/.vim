vim9script

if exists("b:did_after_ftplugin")
    finish
endif
b:did_after_ftplugin = 1

import autoload 'popup.vim'

nnoremap <buffer> i <scriptcmd>popup.ShowAtCursor(getqflist()[line('.') - 1].text)<CR>
