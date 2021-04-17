func! s:setup_colors(colorscheme) abort
    if !has('gui_running')
        hi Normal ctermbg=NONE
    endif

    if a:colorscheme == "freyeday"
        hi NormalFade ctermbg=255 ctermfg=NONE cterm=NONE guibg=#eeeeee gui=NONE guifg=NONE
    elseif a:colorscheme == "saturnite"
        hi NormalFade ctermbg=235 ctermfg=NONE cterm=NONE guibg=#262626 gui=NONE guifg=NONE
    endif
endfunc


augroup haba_colors | au!
    au ColorScheme freyeday,saturnite call s:setup_colors(expand("<amatch>"))
    au WinEnter * setl wincolor=Normal
    au WinLeave * setl wincolor=NormalFade
augroup END


if has('gui_running')
    colorscheme freyeday
else
    colorscheme saturnite
endif
