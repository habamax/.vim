vim9script

import autoload 'json.vim'
setl formatexpr=json.FormatExpr()
xnoremap <buffer> gq <scriptcmd>json.FormatRange(line('v'), line('.'))<CR>

setlocal expandtab shiftwidth=2


if executable('jq')
    &l:formatprg = "jq -e"
elseif executable('js-beautify')
    # sudo npm -g install js-beautify
    &l:formatprg = "js-beautify -s 2 -f -"
elseif executable('python')
    &l:formatprg = "python -m json.tool"
endif

if !empty(&l:formatprg)
    command! -buffer Fmt normal gggqG
endif

if exists(":Fmt") == 2
    augroup Curl | au!
        autocmd User CurlOutput Fmt
    augroup END
endif
