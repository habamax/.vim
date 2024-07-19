vim9script

import autoload 'popup.vim'

# Navigate quickfix/location lists.
# Usage:
# import autoload 'nav.vim'
# nnoremap <space>q <scriptcmd>nav.Qf()<CR>
export def Qf()
    var commands = []
    if len(getqflist()) > 0
        commands->extend([
            {text: "Quickfix"},
            {key: "j", cmd: "cnext"},
            {key: "k", cmd: "cprev"},
            {key: "J", cmd: "clast"},
            {key: "K", cmd: "cfirst"},
        ])
    endif
    if len(getloclist(winnr())) > 0
        commands->extend([
            {text: "Locations"},
            {key: ".", cmd: "lnext"},
            {key: ",", cmd: "lprev"},
            {key: ">", cmd: "llast"},
            {key: "<", cmd: "lfirst"},
        ])
    endif
    popup.Commands(commands)
enddef

# Navigate windows
# Usage:
# import autoload 'nav.vim'
# nnoremap <C-w>h <scriptcmd>nav.Windows("h")<cr>
# nmap <C-w><C-h> <C-w>h
# nnoremap <C-w>j <scriptcmd>nav.Windows("j")<cr>
# nmap <C-w><C-j> <C-w>j
# nnoremap <C-w>k <scriptcmd>nav.Windows("k")<cr>
# nmap <C-w><C-k> <C-w>k
# nnoremap <C-w>l <scriptcmd>nav.Windows("l")<cr>
# nmap <C-w><C-l> <C-w>l
export def Windows(initial: string)
    exe "wincmd" initial
    var commands = []
    if winnr('$') > 1
        commands->extend([
            {text: "Windows"},
            {key: "h", cmd: "wincmd h"},
            {key: "j", cmd: "wincmd j"},
            {key: "k", cmd: "wincmd k"},
            {key: "l", cmd: "wincmd l"},
        ])
    endif
    popup.Commands(commands)
enddef
