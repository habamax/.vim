vim9script

var undo_maps = 'exe "nunmap <buffer> <F5>"'
    .. ' | exe "nunmap <buffer> <F6>"'
    .. ' | exe "nunmap <buffer> <F7>"'


if exists('b:undo_ftplugin')
    b:undo_ftplugin ..= ' | ' .. undo_maps
else
    b:undo_ftplugin = undo_maps
endif

nnoremap <buffer> <F5> <scriptcmd>Sh cargo run<cr>
nnoremap <buffer> <F6> <scriptcmd>Sh cargo build<cr>
nnoremap <buffer> <F7> <scriptcmd>Sh cargo build --release<cr>
