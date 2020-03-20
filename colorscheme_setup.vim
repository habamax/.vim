""" Customize colors {{{1
func! s:my_colorschemes_setup() abort
    hi Comment gui=italic
endfunc

augroup colorscheme_change | au!
    au ColorScheme defminus,defnoche,lessthan call s:my_colorschemes_setup()
augroup END


""" Colorschemes {{{1

" If it happens you run vim late, use dark colors
if strftime("%H") >= 20 || strftime("%H") < 8 
    " flat colors... or not
    if !has('nvim')
        let g:habamax_flat = rand()%2
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
nnoremap yof :let g:habamax_flat = !g:habamax_flat <bar> colo habamax<CR>
