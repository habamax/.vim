set termguicolors


func! s:apprentice() abort
    hi Title gui=bold cterm=bold
    hi Statusline gui=bold cterm=bold
    hi StatuslineTerm gui=bold cterm=bold
    hi Cursor guifg=#BCBCBC
    hi DiffDelete cterm=reverse ctermfg=235 ctermbg=131 gui=reverse guifg=#262626 guibg=#af5f5f
    hi DiffChange none
endfunc

augroup colorscheme_change | au!
    au ColorScheme apprentice call s:apprentice()
augroup END


if !has("gui_running") || strftime("%H") >= 20 || strftime("%H") <= 6
    " colorscheme gruvbit
    colorscheme apprentice
else
    exe "colorscheme "..["miday", "polar"][rand(srand())%2]
endif
