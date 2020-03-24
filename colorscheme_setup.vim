""" Customize colors {{{1
func! s:my_colorschemes_setup() abort
    hi Comment gui=italic
endfunc

augroup colorscheme_change | au!
    au ColorScheme defminus,defnoche,lessthan call s:my_colorschemes_setup()
augroup END


""" Colorschemes {{{1
let force_dark = v:true

" If it happens you run vim late or in linux or use terminal, use dark colors
if force_dark
            \ || strftime("%H") >= 20
            \ || strftime("%H") < 8
            \ || has('linux')
            \ || !has('gui_running')
    " flat colors... or not
    if !has('nvim')
        let g:habamax_flat = rand()%2
        if !g:habamax_flat
            let g:habamax_godot = rand()%2
        endif
    else
        let g:habamax_flat = v:true
    endif
    set bg=dark
else
    set bg=light
    let g:habamax_flat = v:false
endif


colorscheme habamax

" mimic tpope's unimpaired with toggling options
nnoremap <silent> yof :let g:habamax_flat = !g:habamax_flat <bar> colo habamax<CR>
