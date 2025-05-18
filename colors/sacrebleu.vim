" sacrebleu colorscheme
"
" Wouldn't it be fun to have beautiful blue colorscheme with almost default dark
" syntax highlighting? Handcrafted for now to test the idea.
"
" - Bluish (#02468a) background for GUI and termguicolors.
" - Bluish chrome
" - Default dark vim syntax without bold for Statement and Type.
"
" TODO:
" - Diff
" - Spell
" - PmenuMatch/Kind/Extra

set background=dark

hi clear
let g:colors_name = 'sacrebleu'

hi Normal guifg=#eeeeee guibg=#02468a gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#005faf gui=NONE cterm=NONE
hi LineNr guifg=#5f87af guibg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi Visual guifg=#02367a guibg=#5fafd7 gui=NONE cterm=NONE
hi VertSplit guifg=#5f87af guibg=NONE gui=NONE cterm=NONE
hi StatusLine guifg=#000087 guibg=#afd7ff gui=NONE cterm=NONE
hi StatusLineNC guifg=#000087 guibg=#5f87af gui=NONE cterm=NONE
hi ToolbarButton guifg=#ffffff guibg=#0087af gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Folded guifg=#5f87af guibg=#02367a gui=NONE cterm=NONE

hi Todo guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold

hi ErrorMsg guifg=#ffffff guibg=#d75faf gui=NONE cterm=NONE
hi WarningMsg guifg=#d787d7 guibg=NONE gui=NONE cterm=NONE
hi MoreMsg guifg=#87d787 guibg=NONE gui=NONE cterm=NONE

hi ColorColumn guibg=#013579
hi Conceal guifg=#5f87af guibg=#013579
hi EndOfBuffer guifg=#5f87af ctermfg=NONE

hi Pmenu guifg=NONE guibg=#2266aa gui=NONE cterm=NONE
hi PmenuSel guifg=NONE guibg=#3296da gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#5f87af gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#87d7ff gui=NONE cterm=NONE

" hi PmenuMatch guifg=#ffd700 guibg=#008787 gui=NONE cterm=NONE
" hi PmenuMatchSel guifg=#ff7f50 guibg=#ffffff gui=NONE cterm=NONE
" hi PmenuKind guifg=#5f8787 guibg=#008787 gui=NONE cterm=NONE
" hi PmenuKindSel guifg=#5f8787 guibg=#ffffff gui=NONE cterm=NONE
" hi PmenuExtra guifg=#767676 guibg=#008787 gui=NONE cterm=NONE
" hi PmenuExtraSel guifg=#9e9e9e guibg=#ffffff gui=NONE cterm=NONE
" hi PmenuMatch guifg=#ffaf5f guibg=#008787 gui=NONE cterm=NONE
" hi PmenuMatchSel guifg=#ffaf5f guibg=#ffffff gui=NONE cterm=NONE

hi SpecialKey guifg=#5f87af gui=NONE cterm=NONE
hi Directory gui=bold cterm=bold
hi Title guifg=NONE ctermfg=NONE gui=bold cterm=bold
hi Comment guifg=#62a6ca
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
