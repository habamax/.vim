set background=dark

hi clear
let g:colors_name = 'iris'

hi Normal guifg=#ffffff guibg=#02468a gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#005faf gui=NONE cterm=NONE
hi LineNr guifg=#5f87af guibg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi Visual guifg=#02367a guibg=#2087d7 gui=NONE cterm=NONE
hi VertSplit guifg=#5f87af guibg=NONE gui=NONE cterm=NONE
hi StatusLine guifg=#000087 guibg=#afd7ff gui=NONE cterm=NONE
hi StatusLineNC guifg=#000087 guibg=#5f87af gui=NONE cterm=NONE
hi Folded guifg=#5f87af guibg=#02367a gui=NONE cterm=NONE

hi WarningMsg guifg=#d787d7 guibg=NONE gui=NONE cterm=NONE

hi ColorColumn guibg=#013579
hi Conceal guifg=#5f87af guibg=#013579
hi EndOfBuffer guifg=#5f87af ctermfg=NONE

hi Pmenu guifg=#ffffff guibg=#2266aa gui=NONE cterm=NONE
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

hi SpecialKey guifg=#87afd7 gui=NONE cterm=NONE
hi Directory gui=bold cterm=bold
hi Title guifg=NONE ctermfg=NONE gui=bold cterm=bold
hi Identifier gui=NONE cterm=NONE
hi Underlined guifg=NONE ctermfg=NONE
hi Statement gui=NONE
hi Type gui=NONE

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
hi! link vimCommentString Comment
hi! link vimVar Normal
hi! link vimOper Normal
hi! link vimSep Normal
hi! link vimParenSep Normal
hi! link yamlBlockMappingKey Statement
hi! link rubyMacro Statement
hi! link rubyDefine Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link sqlKeyword Statement
hi! link sqlSpecial Constant
hi! link Quote String
hi! link markdownUrl String
hi! link asciidoctorH1Delimiter Statement
hi! link asciidoctorH2Delimiter Statement
hi! link asciidoctorH3Delimiter Statement
hi! link asciidoctorH4Delimiter Statement
hi! link asciidoctorH5Delimiter Statement
hi! link asciidoctorH6Delimiter Statement
hi! link asciidoctorSetextHeaderDelimiter Statement
hi! link asciidoctorTitleDelimiter Statement
hi! link asciidoctorListMarker Constant
hi! link asciidoctorBlock Special
hi! link asciidoctorCode String
hi! link asciidoctorOption Special
hi! link asciidoctorMacro Special
hi! link lspDiagVirtualTextError Removed
hi! link lspDiagSignErrorText Removed
hi! link lspDiagVirtualTextWarning Changed
hi! link lspDiagSignWarningText Changed
hi! link lspDiagVirtualTextHint Added
hi! link lspDiagSignHintText Added
hi! link lspDiagVirtualTextInfo Question
hi! link lspDiagSignInfoText Question
