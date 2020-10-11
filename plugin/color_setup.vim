""" Customize colors {{{1

augroup colorscheme_change | au!
    au ColorScheme * hi Comment gui=italic cterm=italic
augroup END


""" Colorschemes {{{1

set termguicolors

"" different environments could have different colorschemes
if exists("$COLORSCHEME") && !has("gui_running")
    let g:{$COLORSCHEME}_transp_bg = v:true
    colorscheme $COLORSCHEME
elseif strftime("%H") >= 20 || strftime("%H") <= 6
    colorscheme gruvbit
else
    colorscheme rutine
endif
