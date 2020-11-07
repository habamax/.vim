if executable('js-beautify')
    command! -buffer Format :silent %!js-beautify -f - --type html
elseif executable('tidy')
    command! -buffer Format :silent %!tidy -q -i --show-errors 0
endif

if exists(":Format")
    augroup Curl | au!
        autocmd User CurlOutput Format
    augroup END
endif
