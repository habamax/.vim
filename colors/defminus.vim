" Vim color scheme
"
" Name:       defminus.vim
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT
"
" GUI only `Black On White` colorscheme based on default vim colorscheme.
" There are colors of course. Но это не точно.

set background=light

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'defminus'

"" General
hi Normal guibg=#ffffff guifg=#000000 gui=NONE
hi Cursor guibg=#000000
hi lCursor guibg=#ff0000
hi NonText guibg=NONE guifg=#c0c0c0
hi SpecialKey guibg=NONE guifg=#c0c0c0
hi Visual guibg=#c9c9c9 guifg=NONE

hi Directory guibg=NONE guifg=#000000 gui=bold
hi Title guibg=NONE guifg=#0050ff gui=bold
hi Todo guibg=NONE guifg=#000000 gui=bold

"" UI
hi Statusline guibg=#000000 guifg=#ffffff gui=bold
hi StatuslineNC guibg=#000000 guifg=#909090 gui=NONE
hi Folded guibg=#eaeaea guifg=#505050 gui=NONE
hi FoldColumn guibg=#eaeaea
hi SignColumn guibg=NONE
hi Pmenu guibg=#eaeaea guifg=#505050 gui=NONE
hi PmenuSel guibg=#c0c0c0 guifg=#505050 gui=bold

"" Syntax

" generic
hi Comment guifg=#909090 gui=italic
hi Constant guifg=#505050 gui=NONE
hi Identifier guifg=#505050 gui=NONE
hi Statement guifg=#000000 gui=bold
hi PreProc guifg=#000000 gui=NONE
hi Type guifg=#000000 gui=NONE
hi Special guifg=#a05050 gui=NONE
hi Underlined guifg=#5050c0 gui=underline

" vim
hi link vimFuncName Statement
hi link vimVar Normal
hi link vimParenSep Normal
hi vimCommentTitle gui=italic

" python
hi link pythonInclude Statement
hi link pythonBuiltin Statement

" ruby
hi link rubyInclude Statement
hi link rubyModule Statement
hi link rubyClass Statement
hi link rubyMacro Statement
hi link rubyStringDelimiter Constant
hi link rubyDefine Statement
hi link rubyMethodName Normal

" lua
hi link luaFunction Statement

" elixir
hi link elixirModuleDefine Statement
hi link elixirInclude Statement
hi link elixirDefine Statement
hi link elixirAtom Identifier
hi link elixirExUnitMacro Statement
hi link elixirBlockDefinition Statement
hi link elixirFunctionDeclaration Normal

" properties
hi link jpropertiesIdentifier Statement
hi link jpropertiesString Normal

" kotlin
hi link ktStructure Statement
hi link ktModifier Statement

"" Diff
hi diffAdd guibg=#c9f9c9
hi diffChange guibg=#f9f9c9
hi diffText guibg=#f9d999 guifg=NONE gui=NONE
hi diffDelete guibg=#f9c9c9 guifg=#707070 gui=NONE

"" fugitive
hi link fugitiveHeading Title
hi link fugitiveModifier Identifier
hi link diffIndexLine Constant
hi link diffFile Title
hi diffLine guibg=NONE guifg=#000000 gui=bold,underline
hi diffSubName guibg=NONE guifg=#000000 gui=bold,underline
hi diffAdded guibg=NONE guifg=#009000
hi diffRemoved guibg=NONE guifg=#c00000
hi link gitCommitSummary Title

"" minpac
hi link minpacName Statement
