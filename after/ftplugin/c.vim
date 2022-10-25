vim9script

if exists("g:loaded_ale")
    nnoremap <silent><buffer> K <scriptcmd>ALEHover<CR>
    nnoremap <silent><buffer> gd <scriptcmd>ALEGoToDefinition<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
endif
