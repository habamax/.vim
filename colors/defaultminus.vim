" Vim color scheme
"
" Name:       defaultminus.vim
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT
"
" GUI only `Black On White` colorscheme based on default vim colorscheme.
" 

set background=light

hi clear
if exists('syntax_on')
   syntax reset
endif

let g:colors_name = 'defaultminus'

hi Normal guibg=#ffffff guifg=#000000 gui=NONE
hi Cursor guibg=#000000
hi lCursor guibg=#ff0000
hi NonText guibg=NONE guifg=#c0c0c0
hi SpecialKey guibg=NONE guifg=#c0c0c0

hi Directory guibg=NONE guifg=#000000 gui=bold
hi Title guibg=NONE guifg=#ff00ff gui=bold
hi Todo guibg=NONE guifg=#000000 gui=bold

hi Statusline guibg=#000000 guifg=#ffffff gui=bold
hi StatuslineNC guibg=#000000 guifg=#909090 gui=NONE
hi Folded guibg=#e0e0e0 guifg=#505050 gui=underline
hi Pmenu guibg=#e0e0e0 guifg=#505050 gui=NONE
hi PmenuSel guibg=#c0c0c0 guifg=#505050 gui=bold

" " Signs. 
" call s:hi('SignColumn')

" Syntax

hi Comment guifg=#b0b0b0 gui=italic
hi Constant guifg=#707070 gui=NONE
hi Identifier guifg=#707070 gui=NONE
hi Statement guifg=#000000 gui=bold
hi PreProc guifg=#000000 gui=NONE
hi Type guifg=#000000 gui=NONE
hi Special guifg=#707070 gui=NONE
