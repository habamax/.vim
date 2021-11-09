augroup colorscheme | au!
    hi VertSplit guibg=NONE ctermbg=NONE
    au Colorscheme noco,saturnite,bronzage,sugarlily hi VertSplit guibg=NONE ctermbg=NONE
    au Colorscheme sugarlily hi Normal guibg=#e4e8e4 ctermbg=254
augroup END

exe "silent! colorscheme " . (has("gui_running") ? "sugarlily" : "bronzage")
