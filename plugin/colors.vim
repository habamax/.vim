augroup colorscheme | au!
    au Colorscheme noco,saturnite,bronzage,sugarlily hi VertSplit guibg=NONE ctermbg=NONE
augroup END

if !has("gui_running")
    let s:color = "bronzage"
else
    let hour = strftime("%H")
    if hour > 18 || hour < 7
        let s:color = "bronzage"
    else
        let s:color = "sugarlily"
    endif
endif

exe "silent! colorscheme " . s:color
