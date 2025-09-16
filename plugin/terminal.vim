vim9script

import autoload 'terminal.vim'

augroup Terminal
    au!
    au TerminalWinOpen * {
        nnoremap <buffer> gq <scriptcmd>bd<CR>
        nnoremap <buffer> <CR> <scriptcmd>terminal.OpenError()<CR>
        nnoremap <buffer> o <scriptcmd>terminal.OpenError(true)<CR>
        nmap <buffer> <2-LeftMouse> o
        nnoremap <buffer> J <scriptcmd>terminal.NextError()<CR>
        nnoremap <buffer> K <scriptcmd>terminal.PrevError()<CR>
    }
augroup END
