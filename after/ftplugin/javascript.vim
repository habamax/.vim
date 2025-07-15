setlocal expandtab shiftwidth=2

if executable('js-beautify')
    " sudo npm -g install js-beautify
    command! -buffer Fmt :silent %!js-beautify -s 2 -f -
    let &l:formatprg = "js-beautify -s 2 -f -"
endif
