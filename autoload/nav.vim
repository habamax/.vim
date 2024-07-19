vim9script

import autoload 'popup.vim'

# Navigate quickfix/location lists.
# Usage:
# import autoload 'nav.vim'
# nnoremap <space>q <scriptcmd>nav.Qf()<CR>
export def Qf()
    var commands = [
        {key: "j", cmd: "cnext"},
        {key: "k", cmd: "cprev"},
        {key: "J", cmd: "clast"},
        {key: "K", cmd: "cfirst"},
        {text: "----------"},
        {key: ".", cmd: "lnext"},
        {key: ",", cmd: "lprev"},
        {key: ">", cmd: "llast"},
        {key: "<", cmd: "lfirst"},
    ]
    popup.Commands(commands)
enddef
