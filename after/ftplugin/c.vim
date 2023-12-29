vim9script

setlocal commentstring=//%s

def Make()
    if filereadable("Makefile")
        Sh make
    else
        var fname = expand("%:p:r")
        exe $"Sh make {fname} && chmod +x {fname} && {fname}"
    endif
enddef

nnoremap <buffer><F5> <scriptcmd>Make()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
# nnoremap <silent><buffer> <F5> <cmd>make %<<CR>:redraw!<CR>:!./%<<CR>
# b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

if exists("g:loaded_lsp")
    setlocal keywordprg=:LspHover
    nnoremap <silent><buffer> gd <scriptcmd>LspGotoDefinition<CR>
    b:undo_ftplugin ..= ' | setl keywordprg<'
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> gd"'
endif
