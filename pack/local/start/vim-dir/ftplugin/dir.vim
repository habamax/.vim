vim9script

# XXX: handle b:undo

import autoload 'dir.vim'


nnoremap <buffer> <bs> <scriptcmd>dir.ActionUp()<cr>
nnoremap <buffer> <cr> <scriptcmd>dir.Action()<cr>
nnoremap <buffer> s <scriptcmd>dir.Action("split")<cr>
nnoremap <buffer> v <scriptcmd>dir.Action("vert split")<cr>
nnoremap <buffer> t <scriptcmd>dir.Action("tabe")<cr>
nnoremap <buffer> i <scriptcmd>dir.ActionPreview()<cr>


augroup dirautocommands | au!
    au BufReadCmd dir://* dir.Open()
augroup END
