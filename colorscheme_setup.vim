""" Customize colors {{{1

func! s:habamax_setup() abort
    if !get(g:, "habamax_flat", 0) && exists("*asciidoctor#force_default_colors")
        call asciidoctor#force_default_colors()
    endif
endfunc

augroup colorscheme_change | au!
    au ColorScheme habamax call s:habamax_setup()
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

if exists('g:started_by_firenvim')
    set bg=light
elseif strftime("%H") >= 20 || strftime("%H") < 8
            \ || has('linux') || !has('gui_running')
    set bg=dark
else
    set bg=light
endif

let g:habamax_flat = get(g:, "habamax_flat", v:false)
let g:habamax_fancy = get(g:, "habamax_fancy", v:true)
let g:habamax_contrast = get(g:, "habamax_contrast", v:false)
" g:habamax_dirty -- will make light background a bit darker
let g:habamax_dirty = get(g:, "habamax_dirty", v:false)
" handy if you use it with transparent terminals
let g:habamax_transparent = get(g:, "habamax_transparent", v:false)
colorscheme habamax

" mimic tpope's unimpaired with toggling options
nnoremap <silent> yoF :let g:habamax_flat = !g:habamax_flat <bar> colo habamax<CR>
nnoremap <silent> yof :let g:habamax_fancy = !g:habamax_fancy <bar> colo habamax<CR>
nnoremap <silent> yot :call <SID>habamax_next_contrast()<CR>
nnoremap <silent> yoT :let g:habamax_transparent = !g:habamax_transparent <bar> colo habamax<CR>

"" loop over habamax contrast settings
func! s:habamax_next_contrast() abort
    if get(g:, "habamax_transparent", v:false)
        let g:habamax_transparent = v:false
    elseif &background == 'light'
        " ring of (->regular -> dirty -> contrast->)
        if !g:habamax_contrast && !g:habamax_dirty
            let g:habamax_contrast = v:false
            let g:habamax_dirty = v:true
            echo "habamax dirty"
        elseif !g:habamax_contrast && g:habamax_dirty
            let g:habamax_contrast = v:true
            let g:habamax_dirty = v:false
            echo "habamax contrast white"
        else
            let g:habamax_contrast = v:false
            let g:habamax_dirty = v:false
            echo "habamax white green"
        endif
    else
        let g:habamax_contrast = !g:habamax_contrast
    endif
    colorscheme habamax
endfunc
