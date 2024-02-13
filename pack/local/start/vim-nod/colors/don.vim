" Name:         don
" Description:  Light colorscheme? Yes!
" Author:       Maxim Kim <habamax@gmail.com>
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Website:      https://github.com/habamax/.vim/tree/master/pack/local/start/vim-nod
" License:      Same as Vim
" Last Updated: Tue 13 Feb 2024 21:07:15

" Generated by Colortemplate v2.2.3

set background=light

hi clear
let g:colors_name = 'don'

let s:t_Co = has('gui_running') ? -1 : (&t_Co ?? 0)

hi! link Terminal Normal
hi! link StatuslineTerm Statusline
hi! link StatuslineTermNC StatuslineNC
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow PMenu
hi! link PopupNotification Todo
hi! link CurSearch IncSearch
hi! link sqlKeyword Statement
hi! link Quote String
hi! link markdownUrl String
hi! link markdownHeadingDelimiter Statement
hi! link markdownListMarker Constant
hi! link rstSectionDelimiter Statement
hi! link rstDirective Special
hi! link lspDiagVirtualTextError Removed
hi! link lspDiagSignErrorText Removed
hi! link lspDiagVirtualTextWarning Changed
hi! link lspDiagSignWarningText Changed
hi! link lspDiagVirtualTextHint Added
hi! link lspDiagSignHintText Added
hi! link lspDiagVirtualTextInfo Question
hi! link lspDiagSignInfoText Question

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#d7005f', '#008700', '#af5f00', '#005faf', '#af00af', '#008787', '#eeeeee', '#9e9e9e', '#ff0087', '#00af00', '#d7875f', '#0087ff', '#d700d7', '#00afaf', '#ffffff']
endif
hi Normal guifg=#000000 guibg=#eeeeee gui=NONE cterm=NONE
hi Statusline guifg=#000000 guibg=#bcbcbc gui=bold cterm=bold
hi StatuslineNC guifg=#000000 guibg=#d0d0d0 gui=NONE cterm=NONE
hi VertSplit guifg=#bcbcbc guibg=NONE gui=NONE cterm=NONE
hi TabLine guifg=#000000 guibg=#d0d0d0 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#000000 guibg=#bcbcbc gui=bold cterm=bold
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#000000 guibg=#d0d0d0 gui=NONE cterm=NONE
hi QuickFixLine guifg=#eeeeee guibg=#d700d7 gui=NONE cterm=NONE
hi CursorLineNr guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi LineNr guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi FoldColumn guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#9e9e9e guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=#000000 guibg=#dadada gui=NONE cterm=NONE
hi PmenuSel guifg=#eeeeee guibg=#d7875f gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#9e9e9e gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuKind guifg=#ff0087 guibg=#dadada gui=NONE cterm=NONE
hi PmenuKindSel guifg=#d7005f guibg=#d7875f gui=NONE cterm=NONE
hi PmenuExtra guifg=#9e9e9e guibg=#dadada gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#000000 guibg=#d7875f gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#d7005f guibg=#eeeeee gui=reverse cterm=reverse
hi ErrorMsg guifg=#d7005f guibg=#eeeeee gui=reverse cterm=reverse
hi ModeMsg guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi MoreMsg guifg=#00af00 guibg=NONE gui=NONE cterm=NONE
hi Question guifg=#d700d7 guibg=NONE gui=NONE cterm=NONE
hi WarningMsg guifg=#d7875f guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#008700 guibg=#eeeeee gui=bold,reverse cterm=bold,reverse
hi Search guifg=#eeeeee guibg=#0087ff gui=NONE cterm=NONE
hi IncSearch guifg=#eeeeee guibg=#d7875f gui=NONE cterm=NONE
hi WildMenu guifg=#eeeeee guibg=#d7875f gui=NONE cterm=NONE
hi debugPC guifg=#005faf guibg=NONE gui=reverse cterm=reverse
hi debugBreakpoint guifg=#008787 guibg=NONE gui=reverse cterm=reverse
hi Cursor guifg=#eeeeee guibg=#000000 gui=NONE cterm=NONE
hi lCursor guifg=#000000 guibg=#ff5fff gui=NONE cterm=NONE
hi Visual guifg=#af5f00 guibg=#eeeeee gui=reverse cterm=reverse
hi VisualNOS guifg=#000000 guibg=#00afaf gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#e4e4e4 gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#e4e4e4 gui=NONE cterm=NONE
hi Folded guifg=#9e9e9e guibg=#ffffff gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#ffffff gui=NONE cterm=NONE
hi MatchParen guifg=#ff00af guibg=NONE gui=bold cterm=bold
hi SpellBad guifg=NONE guibg=NONE guisp=#ff0087 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellCap guifg=NONE guibg=NONE guisp=#d7875f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellLocal guifg=NONE guibg=NONE guisp=#00af00 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellRare guifg=NONE guibg=NONE guisp=#d700d7 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=NONE
hi Comment guifg=#9e9e9e guibg=NONE gui=NONE cterm=NONE
hi Constant guifg=#d7005f guibg=NONE gui=NONE cterm=NONE
hi String guifg=#008700 guibg=NONE gui=NONE cterm=NONE
hi Character guifg=#00af00 guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#008787 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#af5f00 guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#005faf guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#af00af guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#8700ff guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#0087ff guibg=NONE gui=underline cterm=underline
hi Title guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi Directory guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi Conceal guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#5f875f guibg=#eeeeee gui=reverse cterm=reverse
hi DiffChange guifg=#5f87af guibg=#eeeeee gui=reverse cterm=reverse
hi DiffText guifg=#af5faf guibg=#eeeeee gui=reverse cterm=reverse
hi DiffDelete guifg=#875f5f guibg=#eeeeee gui=reverse cterm=reverse
hi Added guifg=#00af00 guibg=NONE gui=NONE cterm=NONE
hi Changed guifg=#d7875f guibg=NONE gui=NONE cterm=NONE
hi Removed guifg=#ff0087 guibg=NONE gui=NONE cterm=NONE

if s:t_Co >= 256
  hi Normal ctermfg=16 ctermbg=255 cterm=NONE
  hi Statusline ctermfg=16 ctermbg=250 cterm=bold
  hi StatuslineNC ctermfg=16 ctermbg=252 cterm=NONE
  hi VertSplit ctermfg=250 ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=16 ctermbg=252 cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=16 ctermbg=250 cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=16 ctermbg=252 cterm=NONE
  hi QuickFixLine ctermfg=255 ctermbg=164 cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi LineNr ctermfg=248 ctermbg=NONE cterm=NONE
  hi NonText ctermfg=248 ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=248 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=248 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=248 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=247 ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=16 ctermbg=253 cterm=NONE
  hi PmenuSel ctermfg=255 ctermbg=173 cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=247 cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuKind ctermfg=198 ctermbg=253 cterm=NONE
  hi PmenuKindSel ctermfg=161 ctermbg=173 cterm=NONE
  hi PmenuExtra ctermfg=247 ctermbg=253 cterm=NONE
  hi PmenuExtraSel ctermfg=16 ctermbg=173 cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=161 ctermbg=255 cterm=reverse
  hi ErrorMsg ctermfg=161 ctermbg=255 cterm=reverse
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=34 ctermbg=NONE cterm=NONE
  hi Question ctermfg=164 ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=173 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=28 ctermbg=255 cterm=bold,reverse
  hi Search ctermfg=255 ctermbg=33 cterm=NONE
  hi IncSearch ctermfg=255 ctermbg=173 cterm=NONE
  hi WildMenu ctermfg=255 ctermbg=173 cterm=NONE
  hi debugPC ctermfg=25 ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=30 ctermbg=NONE cterm=reverse
  hi Visual ctermfg=130 ctermbg=255 cterm=reverse
  hi VisualNOS ctermfg=16 ctermbg=37 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=254 cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=254 cterm=NONE
  hi Folded ctermfg=247 ctermbg=231 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=231 cterm=NONE
  hi MatchParen ctermfg=199 ctermbg=NONE cterm=bold
  hi SpellBad ctermfg=198 ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=173 ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=34 ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=164 ctermbg=NONE cterm=underline
  hi Comment ctermfg=247 ctermbg=NONE cterm=NONE
  hi Constant ctermfg=161 ctermbg=NONE cterm=NONE
  hi String ctermfg=28 ctermbg=NONE cterm=NONE
  hi Character ctermfg=34 ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=30 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=130 ctermbg=NONE cterm=NONE
  hi Type ctermfg=25 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=127 ctermbg=NONE cterm=NONE
  hi Special ctermfg=93 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=33 ctermbg=NONE cterm=underline
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Directory ctermfg=NONE ctermbg=NONE cterm=bold
  hi Conceal ctermfg=248 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=65 ctermbg=255 cterm=reverse
  hi DiffChange ctermfg=67 ctermbg=255 cterm=reverse
  hi DiffText ctermfg=133 ctermbg=255 cterm=reverse
  hi DiffDelete ctermfg=95 ctermbg=255 cterm=reverse
  hi Added ctermfg=34 ctermbg=NONE cterm=NONE
  hi Changed ctermfg=173 ctermbg=NONE cterm=NONE
  hi Removed ctermfg=198 ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 16
  hi Normal ctermfg=black ctermbg=grey cterm=NONE
  hi Statusline ctermfg=black ctermbg=grey cterm=bold
  hi StatuslineNC ctermfg=black ctermbg=grey cterm=NONE
  hi VertSplit ctermfg=grey ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=black ctermbg=grey cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=black ctermbg=grey cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=black ctermbg=grey cterm=NONE
  hi QuickFixLine ctermfg=grey ctermbg=magenta cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi LineNr ctermfg=grey ctermbg=NONE cterm=NONE
  hi NonText ctermfg=grey ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=grey ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=grey ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=black ctermbg=grey cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuKind ctermfg=darkred ctermbg=grey cterm=NONE
  hi PmenuKindSel ctermfg=darkred ctermbg=darkyellow cterm=NONE
  hi PmenuExtra ctermfg=darkgrey ctermbg=grey cterm=NONE
  hi PmenuExtraSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=grey cterm=reverse
  hi ErrorMsg ctermfg=darkred ctermbg=grey cterm=reverse
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=green ctermbg=NONE cterm=NONE
  hi Question ctermfg=magenta ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=yellow ctermbg=NONE cterm=NONE
  hi Todo ctermfg=darkgreen ctermbg=grey cterm=bold,reverse
  hi Search ctermfg=grey ctermbg=blue cterm=NONE
  hi IncSearch ctermfg=grey ctermbg=yellow cterm=NONE
  hi WildMenu ctermfg=grey ctermbg=yellow cterm=NONE
  hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
  hi Visual ctermfg=darkyellow ctermbg=grey cterm=reverse
  hi VisualNOS ctermfg=black ctermbg=cyan cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorColumn ctermfg=black ctermbg=yellow cterm=NONE
  hi Folded ctermfg=black ctermbg=NONE cterm=bold
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=yellow ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=green ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Comment ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
  hi String ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Character ctermfg=green ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Type ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Special ctermfg=magenta ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=blue ctermbg=NONE cterm=underline
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Directory ctermfg=NONE ctermbg=NONE cterm=bold
  hi Conceal ctermfg=grey ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=darkgreen ctermbg=grey cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=grey cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=grey cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=grey cterm=reverse
  hi Added ctermfg=green ctermbg=NONE cterm=NONE
  hi Changed ctermfg=yellow ctermbg=NONE cterm=NONE
  hi Removed ctermfg=red ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 8
  hi Normal ctermfg=grey ctermbg=NONE cterm=NONE
  hi Statusline ctermfg=grey ctermbg=black cterm=bold,reverse
  hi StatuslineNC ctermfg=black ctermbg=grey cterm=NONE
  hi VertSplit ctermfg=grey ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=grey ctermbg=black cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=black ctermbg=grey cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=grey ctermbg=black cterm=bold,reverse
  hi QuickFixLine ctermfg=black ctermbg=darkmagenta cterm=NONE
  hi CursorLineNr ctermfg=black ctermbg=NONE cterm=bold
  hi LineNr ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi NonText ctermfg=black ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=black ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=grey ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=black ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=black ctermbg=grey cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuKind ctermfg=darkred ctermbg=grey cterm=NONE
  hi PmenuKindSel ctermfg=darkred ctermbg=darkyellow cterm=NONE
  hi PmenuExtra ctermfg=black ctermbg=grey cterm=NONE
  hi PmenuExtraSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=black ctermbg=darkred cterm=NONE
  hi ErrorMsg ctermfg=black ctermbg=darkred cterm=NONE
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Question ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Todo ctermfg=darkgreen ctermbg=black cterm=reverse
  hi Search ctermfg=darkblue ctermbg=black cterm=reverse
  hi IncSearch ctermfg=darkyellow ctermbg=black cterm=reverse
  hi WildMenu ctermfg=black ctermbg=darkyellow cterm=NONE
  hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
  hi Visual ctermfg=darkyellow ctermbg=black cterm=reverse
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi VisualNOS ctermfg=black ctermbg=darkcyan cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Folded ctermfg=grey ctermbg=NONE cterm=bold
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=reverse
  hi SpellCap ctermfg=darkyellow ctermbg=NONE cterm=reverse
  hi SpellLocal ctermfg=darkgreen ctermbg=NONE cterm=reverse
  hi SpellRare ctermfg=darkmagenta ctermbg=NONE cterm=reverse
  hi Comment ctermfg=NONE ctermbg=NONE cterm=bold
  hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
  hi String ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Statement ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Type ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Directory ctermfg=NONE ctermbg=NONE cterm=bold
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=black ctermbg=darkgreen cterm=NONE
  hi DiffChange ctermfg=black ctermbg=darkblue cterm=NONE
  hi DiffText ctermfg=black ctermbg=darkmagenta cterm=NONE
  hi DiffDelete ctermfg=black ctermbg=darkred cterm=NONE
  hi Added ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Changed ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Removed ctermfg=darkred ctermbg=NONE cterm=NONE
  unlet s:t_Co
  finish
endif

if s:t_Co >= 0
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=reverse
  hi CursorColumn term=NONE
  hi CursorLine term=underline
  hi CursorLineNr term=bold
  hi DiffAdd term=reverse
  hi DiffChange term=NONE
  hi DiffDelete term=reverse
  hi DiffText term=reverse
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,reverse
  hi FoldColumn term=NONE
  hi Folded term=NONE
  hi IncSearch term=bold,reverse,underline
  hi LineNr term=NONE
  hi MatchParen term=bold,underline
  hi ModeMsg term=bold
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=reverse
  hi PmenuSel term=bold
  hi PmenuThumb term=NONE
  hi Question term=standout
  hi Search term=reverse
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=underline
  hi SpellCap term=underline
  hi SpellLocal term=underline
  hi SpellRare term=underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=bold,underline
  hi TabLine term=bold,underline
  hi TabLineFill term=NONE
  hi Terminal term=NONE
  hi TabLineSel term=bold,reverse
  hi Title term=NONE
  hi VertSplit term=NONE
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  hi CurSearch term=reverse
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
  hi Comment term=bold
  hi Constant term=NONE
  hi Error term=bold,reverse
  hi Identifier term=NONE
  hi Ignore term=NONE
  hi PreProc term=NONE
  hi Special term=NONE
  hi Statement term=NONE
  hi Todo term=bold,reverse
  hi Type term=NONE
  hi Underlined term=underline
  unlet s:t_Co
  finish
endif

" Background: light
" Color: color00                 #000000        16             black
" Color: color08                 #9e9e9e        247            darkgrey
" Color: color01                 #d7005f        161            darkred
" Color: color09                 #ff0087        198            red
" Color: color02                 #008700        28             darkgreen
" Color: color10                 #00af00        34             green
" Color: color03                 #af5f00        130            darkyellow
" Color: color11                 #d7875f        173            yellow
" Color: color04                 #005faf        25             darkblue
" Color: color12                 #0087ff        33             blue
" Color: color05                 #af00af        127            darkmagenta
" Color: color13                 #d700d7        164            magenta
" Color: color06                 #008787        30             darkcyan
" Color: color14                 #00afaf        37             cyan
" Color: color07                 #eeeeee        255            grey
" Color: color15                 #ffffff        231            white
" Color: color16                 #8700ff        93             magenta
" Color: colorLine               #e4e4e4        254            darkgrey
" Color: colorPmenu              #dadada        253            darkgrey
" Color: colorB                  #ffffff        231            darkgrey
" Color: colorNonT               #a8a8a8        248            grey
" Color: colorlC                 #ff5fff        207            magenta
" Color: colorMP                 #ff00af        199            magenta
" Color: colorSt                 #bcbcbc        250            grey
" Color: colorStIn               #d0d0d0        252            grey
" Color: diffAdd                 #5f875f        65             darkgreen
" Color: diffDelete              #875f5f        95             darkred
" Color: diffChange              #5f87af        67             darkblue
" Color: diffText                #af5faf        133            darkmagenta
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" vim: et ts=8 sw=2 sts=2
