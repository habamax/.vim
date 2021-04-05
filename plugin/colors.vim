if !has("gui_running")
    augroup haba_colors | au!
        au Colorscheme freyeday hi Normal ctermbg=NONE
        au Colorscheme saturnite hi Normal ctermbg=NONE
    augroup END
endif

silent! exe 'colorscheme ' .. ($VIMCOLORS ?? 'saturnite')
