augroup colorscheme | au!
    au Colorscheme noco,saturnite,bronzage,sugarlily hi VertSplit guibg=NONE ctermbg=NONE
augroup END

if !has("gui_running")
    silent! colorscheme bronzage
else
    let s:hour = strftime("%H")
    if s:hour > 18 || s:hour < 7
        silent! colorscheme bronzage
    else
        silent! colorscheme sugarlily
    endif
endif
