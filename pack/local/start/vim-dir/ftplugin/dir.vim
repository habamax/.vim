vim9script

import autoload 'dir.vim'


def Action()
    var idx = line('.') - 3
    if idx < 0 | return | endif
    var cwd = trim(b:dir_cwd, '/', 2)
    dir.Open($"{cwd}/{b:dir[idx].name}")
enddef


def ActionUp()
    dir.Open(fnamemodify(b:dir_cwd, ":h"), fnamemodify(b:dir_cwd, ":t"))
enddef


nnoremap <buffer> <cr> <scriptcmd>Action()<cr>
nnoremap <buffer> <bs> <scriptcmd>ActionUp()<cr>
