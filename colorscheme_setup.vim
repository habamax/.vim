""" Customize colors {{{1
func! s:my_colorschemes_setup() abort
    hi Comment gui=italic
endfunc

augroup colorscheme_change | au!
    au ColorScheme defminus,defnoche,lessthan call s:my_colorschemes_setup()
augroup END


"" Terminals {{{1
if !has("gui_running")

    " Fix vim termguicolors for tmux
    if &term =~# '^screen'
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

"" Kind of random of 0 or 1 values
func! s:rand_bool() abort
    if exists('*rand')
        return rand() % 2
    else
        return localtime() % 2
    endif
endfunc

let force_dark = v:true

" If it happens you run vim late or in linux or use terminal, use dark colors
if force_dark
            \ || strftime("%H") >= 20
            \ || strftime("%H") < 8
            \ || has('linux')
            \ || !has('gui_running')
    " flat colors... or not
    let g:habamax_flat = s:rand_bool()
    if !g:habamax_flat
        let g:habamax_godot = s:rand_bool()
    endif
    set bg=dark
else
    set bg=light
    let g:habamax_flat = v:false
endif


colorscheme habamax

" mimic tpope's unimpaired with toggling options
nnoremap <silent> yof :let g:habamax_flat = !g:habamax_flat <bar> colo habamax<CR>
