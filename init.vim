" Source vim's vimrc
source <sfile>:h/vimrc

if exists('g:vscode')
    " commenting
    xmap gc <Plug>VSCodeCommentary
    nmap gc <Plug>VSCodeCommentary
    omap gc <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine

    " folding
    nnoremap <silent> zi :<C-u>call VSCodeNotify('editor.toggleFold')<CR>
    nnoremap <silent> zM :<C-u>call VSCodeNotify('editor.foldAll')<CR>
    nnoremap <silent> zR :<C-u>call VSCodeNotify('editor.unfoldAll')<CR>
    nnoremap <silent> zc :<C-u>call VSCodeNotify('editor.fold')<CR>
    nnoremap <silent> zo :<C-u>call VSCodeNotify('editor.unfold')<CR>

    " files
    nnoremap <silent> <leader>f :<C-u>call VSCodeNotify('workbench.action.quickOpen')<CR>
    nnoremap <silent> <leader>; :<C-u>call VSCodeNotify('workbench.action.showCommands')<CR>
endif
