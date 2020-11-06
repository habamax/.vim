if executable('tidy')
    command! -buffer Format :silent %!tidy -q -i --show-errors 0
endif
