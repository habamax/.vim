vim9script

import autoload 'dir.vim'

def Action()
    var idx = line('.') - 4
    if idx < 0 | return | endif
    dir.Open($"{b:dir_cwd}/{b:dir[idx].name}")
enddef

def ActionUp()
    dir.Open(fnamemodify(b:dir_cwd, ":h"), fnamemodify(b:dir_cwd, ":t"))
enddef

nnoremap <buffer> <cr> <scriptcmd>Action()<cr>
nnoremap <buffer> <bs> <scriptcmd>ActionUp()<cr>
