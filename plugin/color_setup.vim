""" Customize colors {{{1

func! s:default_setup() abort
    if get(g:, "colors_name", "default") != 'default'
        return
    endif
    if &background == "dark"
        hi Normal guibg=black guifg=white ctermbg=black ctermfg=white
        hi Visual guibg=#505050 guifg=NONE
    else
        hi Normal guibg=white guifg=black ctermbg=white ctermfg=black
        hi Visual guibg=#d0d0d0 guifg=NONE
    endif
endfunc

augroup colorscheme_change | au!
    au ColorScheme default call s:default_setup()
    au OptionSet background call s:default_setup()
    " au ColorScheme habanight hi VertSplit guibg=NONE ctermbg=NONE
    " au ColorScheme polar hi VertSplit guibg=NONE ctermbg=NONE
augroup END


""" Colorschemes {{{1

set termguicolors

"" different environments could have different colorschemes
if exists("$COLORSCHEME")
    colorscheme $COLORSCHEME
elseif strftime("%H") >= 20 || strftime("%H") <= 6
    colorscheme habanight
else
    colorscheme polar
endif
