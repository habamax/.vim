""" Customize colors

func! s:customize_colors() abort
    hi Comment gui=italic cterm=italic
    hi StatusLine gui=bold cterm=bold
endfunc

augroup colorscheme_change | au!
    au ColorScheme * call s:customize_colors()
augroup END


""" Colorschemes

set termguicolors

"" different environments could have different colorschemes
if exists("$COLORSCHEME") && !has("gui_running")
    colorscheme $COLORSCHEME
elseif strftime("%H") >= 20 || strftime("%H") <= 6
    colorscheme gruvbit
else
    exe "colorscheme "..["miday", "polar"][rand(srand())%2]
endif
