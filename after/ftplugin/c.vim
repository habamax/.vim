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
    nnoremap <silent><buffer> <space>gr <scriptcmd>YcmCompleter GoToReferences<CR>
    nmap <space>z <Plug>(YCMFindSymbolInWorkspace)
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>gr"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
endif
