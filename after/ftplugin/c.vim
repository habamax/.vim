vim9script

import autoload 'popup.vim'
def YCMPopupDoc()
    var response = youcompleteme#GetCommandResponse('GetDoc')
    if response == '' | return | endif
    popup.ShowAtCursor(response->split('\n'))
enddef


if exists("g:loaded_youcompleteme")
    nnoremap <silent><buffer> K <scriptcmd>YCMPopupDoc()<CR>
    nnoremap <silent><buffer> gd <scriptcmd>YcmCompleter GoTo<CR>
endif
