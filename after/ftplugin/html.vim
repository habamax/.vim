vim9script

setlocal expandtab

if executable('tidy')
    # sudo apt install tidy
    &l:formatprg = $"tidy -q -wrap 0 -i --indent-spaces {&sw} --show-errors 0 --show-body-only auto"
    b:formatprg_err = 1
elseif executable('html-beautify')
    # html-beautify is in js-beautify node package
    # sudo npm -g install js-beautify
    # command! -buffer Fmt :silent %!html-beautify -s 4 -f - --wrap-attributes=force-aligned
    &l:formatprg = "html-beautify -s 4 -f -"
endif
