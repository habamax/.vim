vim9script

setl shiftwidth=0
setl noexpandtab tabstop=4

def RunOdin(file: bool = false)
    update
    var param = !file ? '.' : expand("%") .. ' -file'
    if exists("$WSL_DISTRO_NAME")
        exe $"Term! odin run {param} -thread-count:1"
    else
        exe $"Term! odin run {param}"
    endif
enddef

nnoremap <buffer> <F5> <scriptcmd>RunOdin()<CR>
nnoremap <buffer> <F6> <scriptcmd>RunOdin(1)<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F6>"'

if exists("g:loaded_lsp") && executable('ols')
    g:LspAddServer([{
        name: 'ols',
        filetype: ['odin'],
        path: 'ols',
    }])
    augroup LspSetup
        au!
        au User LspAttached lsp#SetupFT()
    augroup END
endif
