setlocal expandtab

if executable('tidy')
    let &l:formatprg = "tidy -q -i --show-errors 0 --show-body-only auto"
    let b:formatprg_err = 1
elseif executable('html-beautify')
    " html-beautify is in js-beautify node package
    " sudo npm -g install js-beautify
    " command! -buffer Fmt :silent %!html-beautify -s 4 -f - --wrap-attributes=force-aligned
    let &l:formatprg = "html-beautify -s 4 -f -"
endif
