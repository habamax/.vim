" def colorscheme
"
" Vim's default dark-background syntax without sans bold for Statement and Type.
"
" TODO:
" - Diff
" - Spell
" - use colortemplate

set background=dark

hi clear
let g:colors_name = 'def'

hi Normal guifg=#eeeeee guibg=#000000 gui=NONE ctermbg=NONE ctermfg=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#444444 gui=NONE cterm=NONE ctermfg=NONE
hi LineNr guifg=#5f5f5f guibg=NONE gui=NONE cterm=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi Visual guifg=#000000 guibg=#5fafd7 gui=NONE cterm=NONE
hi VertSplit guifg=#878787 guibg=NONE gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi StatusLine guifg=#000000 guibg=#afafaf gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
hi StatusLineNC guifg=#000000 guibg=#878787 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi ToolbarButton guifg=#ffffff guibg=#0087af gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Folded guifg=#808080 guibg=#3a3a3a gui=NONE cterm=NONE
hi Search guifg=#000000 guibg=#d7d75f gui=NONE cterm=NONE
hi IncSearch guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi QuickFixLine guifg=#000000 guibg=#d787d7 gui=NONE cterm=NONE

hi Todo guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold

hi ErrorMsg guifg=#ffffff guibg=#d75faf gui=NONE cterm=NONE
hi WarningMsg guifg=#d787d7 guibg=NONE gui=NONE cterm=NONE
hi MoreMsg guifg=#87d787 guibg=NONE gui=NONE cterm=NONE

hi ColorColumn guibg=#1c1c1c
hi Conceal guifg=#5f5f5f guibg=NONE
hi EndOfBuffer guifg=#5f5f5f ctermfg=NONE

hi Pmenu guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi PmenuSel guifg=NONE guibg=#4e4e4e gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#5f5f5f gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#878787 gui=NONE cterm=NONE
hi PmenuMatch guifg=#ffafff guibg=#303030 gui=NONE cterm=NONE
hi PmenuMatchSel guifg=#ffafff guibg=#4e4e4e gui=NONE cterm=NONE
hi PmenuKind guifg=#5fd75f guibg=#303030 gui=NONE cterm=NONE
hi PmenuKindSel guifg=#5fd75f guibg=#4e4e4e gui=NONE cterm=NONE
hi PmenuExtra guifg=#62a6ca guibg=#303030 gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#72b6da guibg=#4e4e4e gui=NONE cterm=NONE

hi SpecialKey guifg=#5f5f5f gui=NONE cterm=NONE
hi Directory gui=bold cterm=bold
hi Title guifg=NONE ctermfg=NONE gui=bold cterm=bold
hi Identifier gui=NONE cterm=NONE
hi Underlined guifg=NONE ctermfg=NONE
hi Statement gui=NONE
hi Type gui=NONE

hi Removed guifg=#ff5f87

hi! link NonText LineNr
hi! link SignColumn LineNr
hi! link FoldColumn LineNr
hi! link CursorColumn CursorLine
hi! link Terminal Normal
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link TabLineSel StatusLine
hi! link TabPanelFill Normal
hi! link TabPanel Normal
hi! link StatuslineTerm Statusline
hi! link StatuslineTermNC StatuslineNC
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow PMenu
hi! link PopupNotification Todo
hi! link CurSearch IncSearch
hi! link PopupSelected PmenuSel
hi! link lspDiagVirtualTextError Removed
hi! link lspDiagSignErrorText Removed
hi! link lspDiagVirtualTextWarning Changed
hi! link lspDiagSignWarningText Changed
hi! link lspDiagVirtualTextHint Added
hi! link lspDiagSignHintText Added
hi! link lspDiagVirtualTextInfo Question
hi! link lspDiagSignInfoText Question
