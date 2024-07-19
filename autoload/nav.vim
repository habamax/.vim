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
