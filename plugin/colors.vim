if !has("gui_running")
    augroup haba_colors | au!
        au Colorscheme freyeday,saturnite hi Normal ctermbg=NONE
    augroup END
endif

" silent! exe 'colorscheme ' .. ($VIMCOLORS ?? 'saturnite')

" assuming I am in wsltty :)
if exists("$WSLENV")
    for line in readfile(systemlist('wslpath $APPDATA')[0] .. '/wsltty/config')
        let themefile = matchstr(line, 'ThemeFile=\zs.*')
        if !empty(themefile)
            silent! exe 'colorscheme ' .. themefile
            break
        endif
    endfor
else
    colorscheme saturnite
endif
