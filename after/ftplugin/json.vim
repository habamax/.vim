vim9script

setlocal expandtab shiftwidth=2

import autoload 'json.vim'
setl formatexpr=json.FormatExpr()

command -buffer -range=% Fmt json.FormatRange(<line1>, <line2>)

if exists(":Fmt") == 2
    augroup Curl | au!
        autocmd User CurlOutput Fmt
    augroup END
endif
