vim9script

import autoload 'popup.vim'
nnoremap <buffer> i <scriptcmd>popup.ShowAtCursor(getqflist()[line('.') - 1].text)<CR>
