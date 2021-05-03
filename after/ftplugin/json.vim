if executable('js-beautify')
    " sudo npm -g install js-beautify
    command! -buffer Format :silent %!js-beautify -f -
    let &l:formatprg = "js-beautify -f -"
elseif executable('jq')
    command! -buffer Format :%!jq
elseif executable('python')
    command! -buffer Format :%!python -m json.tool
endif

if exists(":Format")
    augroup Curl | au!
        autocmd User CurlOutput Format
    augroup END
endif
