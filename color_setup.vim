""" Customize colors {{{1

func! s:asciidoctor_default() abort
    if !get(g:, "habamax_flat", 0) && exists("*asciidoctor#force_default_colors")
        call asciidoctor#force_default_colors()
    endif
endfunc

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
    hi VertSplit guibg=fg guifg=NONE gui=NONE
endfunc

augroup colorscheme_change | au!
    au ColorScheme * call s:asciidoctor_default()
    au OptionSet background call s:default_setup()
augroup END


"" Terminals {{{1
if !has("gui_running")

    " Fix vim termguicolors for tmux
    " NOTE: your .tmux.conf should have:
    "
    " set -g default-terminal "screen-256color"
    " or 
    " set -g default-terminal "tmux-256color"
    "
    " plus
    " set -ag terminal-overrides ',xterm-256color:Tc'
    if &term =~# '^screen\|tmux' || &term =~# '^xterm-256'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    " Fix vim cursor shape in tmux
    if exists("$TMUX")
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    endif

    if has("linux") || has("nvim")
        set termguicolors
    endif

    " to fix cursor shape in WSL bash add 
    " echo -ne "\e[2 q"
    " to .bashrc
    if &term =~ "xterm"
        let &t_SI = "\<Esc>[6 q"
        let &t_SR = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[2 q"
    endif
endif


""" Colorschemes {{{1

let g:habamax_flat = get(g:, "habamax_flat", v:false)
let g:habamax_contrast = get(g:, "habamax_contrast", v:false)
" handy if you use it with transparent terminals
let g:habamax_transparent = get(g:, "habamax_transparent", v:false)

colorscheme habamax

" mimic tpope's unimpaired with toggling options
nnoremap <silent> yof :let g:habamax_flat = !g:habamax_flat <bar> colo habamax<CR>
nnoremap <silent> yot :call <SID>habamax_next_contrast()<CR>
nnoremap <silent> yoT :let g:habamax_transparent = !g:habamax_transparent <bar> colo habamax<CR>

"" loop over habamax contrast settings
func! s:habamax_next_contrast() abort
    if get(g:, "habamax_transparent", v:false)
        let g:habamax_transparent = v:false
    else
        let g:habamax_contrast = !g:habamax_contrast
    endif
    colorscheme habamax
endfunc
