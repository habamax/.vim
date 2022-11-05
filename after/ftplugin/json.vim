setlocal expandtab shiftwidth=2

setl formatexpr=json#FormatExpr()

if executable('jq')
    let &l:formatprg = "jq -e"
elseif executable('js-beautify')
    " sudo npm -g install js-beautify
    let &l:formatprg = "js-beautify -s 2 -f -"
elseif executable('python')
    let &l:formatprg = "python -m json.tool"
endif

if !empty(&l:formatprg)
    command! -buffer Fmt normal gggqG
endif

if exists(":Fmt")
    augroup Curl | au!
        autocmd User CurlOutput Fmt
    augroup END
endif
