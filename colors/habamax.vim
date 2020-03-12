" habamax.vim -- colorscheme with almost default syntax highlighting
"
" Name:       habamax
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT, but who cares? This is colorscheme.

hi clear
if exists('syntax_on')
	syntax reset
endif


hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'habamax'

if &background == 'light'
    hi Normal guibg=#ecf0ec guifg=#000000
    hi EndOfBuffer guibg=NONE guifg=#e0e0e0
    hi Statusline guibg=#707080 guifg=#ffffff gui=NONE
    hi StatuslineNC guibg=#707080 guifg=#c0c0c0 gui=NONE
    hi VertSplit guibg=#707080 guifg=#c0c0c0 gui=NONE
else
    hi Normal guibg=#202531 guifg=#dedede
    hi EndOfBuffer guibg=NONE guifg=#404551
    hi Statusline guibg=#333b4f guifg=#dedede gui=NONE
    hi StatuslineNC guibg=#333b4f guifg=#636b7f gui=NONE
    hi VertSplit guibg=#333b4f guifg=#636b7f gui=NONE
    hi Error guibg=#633e43 guifg=NONE
endif

hi Comment guifg=#777777 gui=italic
hi Statement gui=NONE
hi Type gui=NONE
hi lCursor guibg=#ff7070

