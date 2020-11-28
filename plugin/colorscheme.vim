func! s:apprentice() abort
    hi Cursor guifg=bg guibg=fg
    hi DiffDelete cterm=reverse ctermfg=235 ctermbg=131 gui=reverse guifg=#262626 guibg=#af5f5f
    hi DiffChange none
endfunc

augroup colorscheme_change | au!
    au ColorScheme apprentice call s:apprentice()
augroup END


set termguicolors


colorscheme mxm

" if !has("gui_running") || strftime("%H") >= 20 || strftime("%H") <= 6
"     colorscheme gruvbit
" else
"     exe "colorscheme "..["miday", "polar"][rand(srand())%2]
" endif
