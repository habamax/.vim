if has('gui_running')
    colorscheme freyeday
else
    augroup haba_colors | au!
        au ColorScheme freyeday,saturnite hi Normal ctermbg=NONE
    augroup END

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
endif
