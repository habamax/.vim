if has('gui_running')
    colorscheme freyeday
else
    augroup haba_colors | au!
        au ColorScheme freyday,saturnite hi Normal ctermbg=NONE
    augroup END
    colorscheme saturnite
endif

