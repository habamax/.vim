vim9script

setlocal commentstring=//%s

def Make()
    if filereadable("Makefile")
        Sh make
    else
        Sh make %< && chmod +x %< && %<
    endif
enddef

nnoremap <buffer><F5> <scriptcmd>Make()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
# nnoremap <silent><buffer> <F5> <cmd>make %<<CR>:redraw!<CR>:!./%<<CR>
# b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

if exists("g:loaded_ale")
    nnoremap <silent><buffer> K <scriptcmd>ALEHover<CR>
    nnoremap <silent><buffer> gd <scriptcmd>ALEGoToDefinition<CR>
    nnoremap <silent><buffer> <space>ar <scriptcmd>ALEFindReferences<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>ar"'
endif
