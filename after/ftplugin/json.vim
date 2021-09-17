if executable('js-beautify')
    " sudo npm -g install js-beautify
    command! -buffer Fmt :silent %!js-beautify -f -
    let &l:formatprg = "js-beautify -f -"
elseif executable('jq')
    command! -buffer Fmt :%!jq
elseif executable('python')
    command! -buffer Fmt :%!python -m json.tool
endif

if exists(":Fmt")
    augroup Curl | au!
        autocmd User CurlOutput Fmt
    augroup END
endif
