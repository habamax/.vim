augroup colorscheme | au!
    au Colorscheme noco,saturnite,bronzage,sugarlily hi VertSplit guibg=NONE ctermbg=NONE
augroup END

exe "silent! colorscheme " . (has("gui_running") ? "sugarlily" : "bronzage")
