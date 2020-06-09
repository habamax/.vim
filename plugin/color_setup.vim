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

func! s:base_setup() abort
    hi Comment gui=italic
    hi Title gui=bold
endfunc

augroup colorscheme_change | au!
    au ColorScheme * call s:asciidoctor_default()
    au ColorScheme default call s:default_setup()
    au ColorScheme apprentice call s:base_setup()
    au OptionSet background call s:default_setup()
augroup END


""" Colorschemes {{{1

let g:habamax_flat = v:false
let g:habamax_contrast = v:false
let g:habamax_transparent = v:false

set background=dark
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
