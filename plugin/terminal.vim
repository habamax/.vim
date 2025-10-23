vim9script

import autoload 'terminal.vim'

def TermMappings()
    nnoremap <buffer> gq <scriptcmd>bd<CR>
    nnoremap <buffer> <CR> <scriptcmd>terminal.OpenError()<CR>
    nnoremap <buffer> o <scriptcmd>terminal.OpenError(true)<CR>
    nmap <buffer> <2-LeftMouse> o
    nnoremap <buffer> J <scriptcmd>terminal.NextError()<CR>
    nnoremap <buffer> K <scriptcmd>terminal.PrevError()<CR>
    nnoremap <buffer> <C-r> <scriptcmd>terminal.ReRun()<CR>
enddef

augroup Terminal
    au!
    au TerminalWinOpen * TermMappings()
    au TerminalOpen * ++nested {
        var buf = expand("<afile>")->escape('#%[ ')
        exe $"au BufWinEnter {buf} ++once TermMappings()"
    }
augroup END
