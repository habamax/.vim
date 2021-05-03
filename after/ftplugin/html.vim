if executable('html-beautify')
    " html-beautify is in js-beautify node package
    " sudo npm -g install js-beautify
    command! -buffer Format :silent %!html-beautify -f -
    " command! -buffer Format :silent %!html-beautify -f - --wrap-attributes=force-aligned
    let &l:formatprg = "html-beautify -f -"
elseif executable('tidy')
    command! -buffer Format :silent %!tidy -q -i --show-errors 0
endif

if exists(":Format")
    augroup Curl | au!
        autocmd User CurlOutput Format
    augroup END
endif
