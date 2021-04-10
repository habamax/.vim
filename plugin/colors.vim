if has('gui_running')
    colorscheme freyeday
else
    augroup haba_colors | au!
        au ColorScheme freyeday,saturnite hi Normal ctermbg=NONE
    augroup END
    colorscheme saturnite
endif

