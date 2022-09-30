vim9script
if executable('html-beautify')
    # html-beautify is in js-beautify node package
    # sudo npm -g install js-beautify
    # command! -buffer Fmt :silent %!html-beautify -s 2 -f - --wrap-attributes=force-aligned
    &l:formatprg = "css-beautify -s 2 -f -"
endif
