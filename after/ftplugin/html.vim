setlocal expandtab shiftwidth=2

if executable('html-beautify')
    " html-beautify is in js-beautify node package
    " sudo npm -g install js-beautify
    command! -buffer Fmt :silent %!html-beautify -s 2 -f -
    " command! -buffer Fmt :silent %!html-beautify -s 2 -f - --wrap-attributes=force-aligned
    let &l:formatprg = "html-beautify -s 2 -f -"
elseif executable('tidy')
    command! -buffer Fmt :silent %!tidy -q -i --show-errors 0
endif

if exists(":Fmt")
    augroup Curl | au!
        autocmd User CurlOutput Fmt
    augroup END
endif
