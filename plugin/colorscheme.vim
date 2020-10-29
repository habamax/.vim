""" Customize colors {{{1

" augroup colorscheme_change | au!
"     au ColorScheme * hi Comment gui=italic cterm=italic
" augroup END


""" Colorschemes {{{1

set termguicolors

"" different environments could have different colorschemes
if exists("$COLORSCHEME") && !has("gui_running")
    colorscheme $COLORSCHEME
elseif strftime("%H") >= 20 || strftime("%H") <= 6
    colorscheme gruvbit
else
    exe "colorscheme "..["miday", "polar"][rand(srand())%2]
endif
