vim9script

import autoload 'dir.vim'



nnoremap <buffer> <cr> <scriptcmd>dir.Action()<cr>
nnoremap <buffer> <bs> <scriptcmd>dir.ActionUp()<cr>


augroup dirautocommands | au!
    # au BufRead <buffer> echom "hello" | dir.Open()
    # au Filetype dir echo "DIR"
augroup END
