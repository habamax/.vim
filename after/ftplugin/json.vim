setlocal expandtab shiftwidth=2

if executable('jq')
    command! -buffer Fmt :%!jq
    let &l:formatprg = "jq -e"
elseif executable('js-beautify')
    " sudo npm -g install js-beautify
    command! -buffer Fmt :silent %!js-beautify -s 2 -f -
    let &l:formatprg = "js-beautify -s 2 -f -"
elseif executable('python')
    command! -buffer Fmt :%!python -m json.tool
    let &l:formatprg = "python -m json.tool"
endif

if exists(":Fmt")
    augroup Curl | au!
        autocmd User CurlOutput Fmt
    augroup END
endif
