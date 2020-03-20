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
    set bg=dark
else
    set bg=light
endif

let g:habamax_flat = v:true
colorscheme habamax

