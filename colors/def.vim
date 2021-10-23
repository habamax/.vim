hi clear
let g:colors_name = 'def'

if &background == 'dark'
    hi Normal guibg=#303030 guifg=#d0d0d0
    hi Folded guibg=#262626 guifg=#00ffff
    hi Visual guifg=bg guibg=fg
    hi Pmenu guifg=NONE guibg=#4e4e4e gui=NONE
    hi PmenuSel guifg=#303030 guibg=#d7d787 gui=NONE
    hi PmenuSbar guifg=NONE guibg=#808080 gui=NONE
    hi PmenuThumb guifg=NONE guibg=#e4e4e4 gui=NONE
    hi SpecialKey guifg=#4e4e4e guibg=NONE gui=NONE
    hi DiffChange guifg=NONE guibg=#3A3A30 gui=NONE
    hi DiffAdd guifg=NONE guibg=#303A30 gui=NONE
    hi DiffText guifg=NONE guibg=#4A4A40 gui=NONE
    hi DiffDelete guifg=#d7875f guibg=#3A3030 gui=NONE
    hi TabLine guibg=#4e4e4e
    hi TabLine gui=NONE
    hi ColorColumn guifg=NONE guibg=#262626 gui=NONE
else
    hi Normal guibg=#f0f0f0 guifg=#000000
    hi Visual guifg=bg guibg=#808080
    hi Pmenu guifg=NONE guibg=#dadada gui=NONE cterm=NONE
    hi PmenuSel guifg=#000000 guibg=#d7af5f gui=NONE cterm=NONE
    hi PmenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PmenuThumb guifg=NONE guibg=#808080 gui=NONE cterm=NONE
    hi SpecialKey guifg=#bcbcbc guibg=NONE gui=NONE cterm=NONE
    hi DiffChange guifg=NONE guibg=#f0f0e0 gui=NONE cterm=NONE
    hi DiffAdd guifg=NONE guibg=#e4eee4 gui=NONE cterm=NONE
    hi DiffText guifg=NONE guibg=#ffffd7
    hi DiffDelete guifg=#d75f5f guibg=#eee4e4 gui=NONE cterm=NONE
    hi TabLine gui=NONE cterm=NONE
    hi ColorColumn ctermfg=NONE ctermbg=255 cterm=NONE
endif

hi VertSplit guifg=fg guibg=NONE gui=NONE cterm=NONE
hi LineNr guifg=#808080
hi FoldColumn guifg=#808080 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guibg=NONE guifg=#808080
hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
