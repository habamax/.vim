""" Customize colors

func! s:apprentice() abort
    hi Title gui=bold cterm=bold
    hi Statusline gui=bold cterm=bold
    hi StatuslineTerm gui=bold cterm=bold
endfunc

augroup colorscheme_change | au!
    au ColorScheme apprentice call s:apprentice()
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
