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

func! s:gruvbit_setup() abort
    hi link CocErrorSign Type
endfunc

augroup colorscheme_change | au!
    au ColorScheme default call s:default_setup()
    au OptionSet background call s:default_setup()
    au ColorScheme * hi Comment gui=italic cterm=italic
    au ColorScheme gruvbit call s:gruvbit_setup()
augroup END


""" Colorschemes {{{1

set termguicolors

"" different environments could have different colorschemes
if exists("$COLORSCHEME")
    colorscheme $COLORSCHEME
elseif strftime("%H") >= 20 || strftime("%H") <= 6
    " colorscheme habanight
    " working on a gruvbox like colorscheme, testing
    colorscheme gruvbit
else
    colorscheme polar
endif
