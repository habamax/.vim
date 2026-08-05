vim9script

setlocal commentstring=//%s
setlocal foldignore=#
b:undo_ftplugin ..= ' | setl commentstring< foldignore<'

g:c_no_curly_error = true

def Make()
    if filereadable("Makefile")
        exe $"{window#BotRight()} TMake"
    else
        var fname = expand("%:p:r")
        exe $"{window#BotRight()} TMake {fname} && chmod +x {fname} && {fname}"
    endif
enddef

nnoremap <buffer><F5> <scriptcmd>Make()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

if exists("g:loaded_lsp") && executable('clangd')
    g:LspAddServer([{
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: ['--background-index'],
    }])

    lsp#SetupFT()
    # augroup LspSetup
    #     au!
    #     au User LspAttached lsp#SetupFT()
    # augroup END
endif


