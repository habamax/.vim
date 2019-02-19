" Vim color scheme
"
" Name:       defminus.vim
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT
"
" GUI only `Black On White` colorscheme based on default vim colorscheme.
" There are colors of course. Но это не точно.
"
" :h 'hl' 
" or
" :h highlight-default 
" to get vim default highlight group names

set background=light

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'defminus'

"" General
hi Normal guibg=#ffffff guifg=#000000 gui=NONE ctermbg=white ctermfg=black
hi Cursor guibg=#000000
hi lCursor guibg=#ff0000
hi NonText guibg=NONE guifg=#c0c0c0
hi SpecialKey guibg=NONE guifg=#c0c0c0
hi Visual guibg=#c9c9c9 guifg=NONE ctermbg=lightgray

hi Directory guibg=NONE guifg=#000000 gui=bold ctermfg=black
hi Title guibg=NONE guifg=#0050ff gui=bold
hi Todo guibg=NONE guifg=#f000f0 gui=bold

"" UI
" hi Statusline guibg=#000000 guifg=#ffffff gui=NONE ctermbg=black ctermfg=white
" hi StatuslineNC guibg=#000000 guifg=#909090 gui=NONE ctermbg=black ctermfg=darkgray
" hi VertSplit guibg=#000000 guifg=#909090 gui=NONE ctermbg=black ctermfg=darkgray
hi Statusline guibg=#e0e0e0 guifg=#000000 gui=underline ctermbg=black ctermfg=white
hi StatuslineNC guibg=#e0e0e0 guifg=#909090 gui=underline ctermbg=black ctermfg=darkgray
hi VertSplit guibg=NONE guifg=#909090 gui=NONE ctermbg=black ctermfg=darkgray
hi WildMenu guibg=#ffff00 guifg=#000000 gui=NONE
hi Folded guibg=#eaeaea guifg=#505050 gui=NONE ctermbg=darkgray ctermfg=black
hi FoldColumn guibg=#eaeaea ctermbg=darkgray ctermfg=black
hi SignColumn guibg=NONE
hi Pmenu guibg=#eaeaea guifg=#505050 gui=NONE ctermbg=lightgray ctermfg=black
hi PmenuSel guibg=#c0c0c0 guifg=#505050 gui=bold ctermbg=darkgray ctermfg=black

"" Syntax

" generic
hi Comment guifg=#909090 gui=italic ctermfg=lightgrey
hi Constant guifg=#505050 gui=NONE ctermfg=darkgrey
hi Identifier guifg=#505050 gui=NONE ctermfg=darkgrey
hi Statement guifg=#000000 gui=bold ctermfg=black
hi PreProc guifg=#000000 gui=NONE ctermfg=black
hi Type guifg=#000000 gui=NONE ctermfg=black
hi Special guifg=#a05050 gui=NONE ctermfg=darkmagenta
hi Underlined guifg=#5050c0 gui=underline ctermbg=darkblue ctermfg=white cterm=underline

" vim
hi link vimFuncName Statement
hi link vimVar Normal
hi link vimParenSep Normal
hi vimCommentTitle gui=italic

" python
hi link pythonInclude Statement
hi link pythonBuiltin Statement
hi link pythonRepeat Statement

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
hi link elixirAtom Constant
hi link elixirExUnitMacro Statement
hi link elixirBlockDefinition Statement
hi link elixirFunctionDeclaration Normal
hi link elixirStringDelimiter Constant
hi link elixirMapDelimiter Special

" properties
hi link jpropertiesIdentifier Statement
hi link jpropertiesString Normal

" kotlin
hi link ktStructure Statement
hi link ktModifier Statement

" C
hi link cInclude Statement
hi link cType Statement

" xml
hi link xmlTagName Statement
hi link xmlTagN Statement
hi link xmlAttrib Constant

" sql
hi link sqlKeyword Statement

" dos batch
hi link dosbatchImplicit Statement

" markdown
hi link markdownListMarker Special
hi link markdownCode Constant

"" Diff
hi diffAdd guibg=#c9f9c9
hi diffChange guibg=#f9f9c9
hi diffText guibg=#f9d999 guifg=NONE gui=NONE
hi diffDelete guibg=#f9c9c9 guifg=#707070 gui=NONE

"" fugitive
hi link fugitiveHeading Title
hi link fugitiveModifier Special
hi link fugitiveSymbolicRef Constant
hi link diffIndexLine Constant
hi link diffFile Title
hi link diffNewFile Title
hi diffLine guibg=NONE guifg=#000000 gui=bold,underline ctermfg=blue
hi diffSubName guibg=NONE guifg=#000000 gui=bold,underline ctermfg=blue
hi diffAdded guibg=NONE guifg=#009000 ctermfg=darkgreen
hi diffRemoved guibg=NONE guifg=#c00000 ctermfg=darkred
hi link gitCommitSummary Title

"" minpac
hi link minpacName Statement

"" UltiSnips
hi link snipSnippetTrigger Normal
hi link snipMirror Special
hi link snipTabStop Special

"" help
hi link helpHeader Title
hi link helpHyperTextEntry Statement
hi link helpHyperTextJump Underlined
hi link helpExample Constant
hi link helpURL Underlined
hi helpSectionDelim guifg=#909090
hi helpOption gui=italic

"" netrw
hi link netrwDateSep Constant
hi link netrwTimeSep Constant
hi link netrwExe Special

"" quickfix
hi link qfFilename Constant
hi link qfSeparator Special
hi link qfLineNr Special

"" LeaderF
" separators have an issue -- they are changed by LeaderF
let s:leaderf_modes = [
			\'File', 'Buffer', 'Mru', 'Help', 'Rg', 
			\'Line', 'BufTag', 'Function', 'Cmd_History',
			\'Colorscheme', 'Self'
			\]
for lf_mode in s:leaderf_modes
	execute 'hi Lf_hl_'.lf_mode.'_stlName guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlMode guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlCategory guibg=#000000 guifg=#c0c0c0 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlCwd guibg=#000000 guifg=#ffffff gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator0 guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator1 guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator2 guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator3 guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator4 guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator5 guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlLineInfo guibg=#000000 guifg=#ffffff gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlNameOnlyMode guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlRegexMode guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlFullPathMode guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlFuzzyMode guibg=#000000 guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlTotal guibg=#000000 guifg=#ffffff gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlBlank guibg=#000000 guifg=#ffffff gui=NONE'
endfor

hi link Lf_hl_bufDirname Comment
hi link Lf_hl_funcDirname Comment
hi link Lf_hl_rgFilename Comment
hi link Lf_hl_rgTagFile Comment

"" CtrlP
hi CtrlPMatch guifg=#1540AD gui=bold

