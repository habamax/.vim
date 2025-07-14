vim9script

if exists("b:did_ftplugin")
    finish
endif

b:did_ftplugin = 1

setl bufhidden=hide
setl buftype=nofile
setl buflisted
setl noswapfile
setl noundofile
setl nonumber norelativenumber
setl keywordprg=:Man

b:undo_ftplugin = 'setl bufhidden< buftype< buflisted< swapfile< undofile<'
b:undo_ftplugin ..= '| setl keywordprg< number< relativenumber<'
b:undo_ftplugin ..= '| exe "nunmap <buffer> gq"'

nnoremap <buffer> gq <C-w>c
