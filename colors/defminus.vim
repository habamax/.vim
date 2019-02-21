" Vim color scheme
"
" Name:       defminus.vim
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT
"
" GUI only `white background` colorscheme.
" There are tons of amaizing `dark background` colorschemes and I use them for
" terminal vim but...
"
" I do really like white backgrounds. Not gray, not "light" -- just plane
" simple white background. The one default GVim provides. But default GVim
" colors are too colorful and too bold.
"
" This has to be fixed. Because why not?
"
"
" :h 'hl' 
" or
" :h highlight-default 
" to get vim default highlight group names
"
" :h group-name
" to see current syntax highlight of default syntax groups

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
hi Visual guibg=#add6ff guifg=NONE ctermbg=lightblue

hi Directory guibg=NONE guifg=#000000 gui=bold ctermfg=black
hi Title guibg=NONE guifg=#3554df gui=bold
hi Todo guibg=NONE guifg=#af00db gui=bold ctermfg=05

"" UI
hi Statusline guibg=#2c2c2c guifg=#ffffff gui=NONE ctermbg=black ctermfg=white
hi StatuslineNC guibg=#5c5c5c guifg=#cbcbcb gui=NONE ctermbg=black ctermfg=white
hi VertSplit guibg=NONE guifg=#5c5c5c gui=NONE ctermbg=black ctermfg=darkgray
" hi VertSplit guibg=#7c7c7c guifg=#cbcbcb gui=NONE ctermbg=black ctermfg=darkgray
hi WildMenu guibg=#ffff00 guifg=#000000 gui=NONE
hi Folded guibg=#f5f5f5 guifg=#505050 gui=NONE ctermbg=darkgray ctermfg=black
hi FoldColumn guibg=#eaeaea ctermbg=darkgray ctermfg=black
hi SignColumn guibg=NONE
hi Pmenu guibg=#eaeaea guifg=#505050 gui=NONE ctermbg=lightgray ctermfg=black
hi PmenuSel guibg=#c0c0c0 guifg=#505050 gui=bold ctermbg=darkgray ctermfg=black

"" Syntax

" generic group-names
hi Comment guifg=#909090 gui=italic ctermfg=lightgrey

" hi Constant guifg=#c05030 gui=NONE ctermfg=darkgrey
hi Constant guifg=#a04327 gui=NONE ctermfg=darkgrey
hi String guifg=#399030 gui=NONE ctermfg=green
hi! link Character Constant
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi Identifier guifg=#505050 gui=NONE ctermfg=darkgrey
hi! link Function Identifier

hi Statement guifg=#af00db gui=NONE ctermfg=05
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Exception Statement

hi PreProc guifg=#000000 gui=NONE ctermfg=black
hi! link Include PreProc
hi! link Define PreProc
hi! link Macro PreProc
hi! link PreCondit PreProc

hi Type guifg=#000000 gui=NONE ctermfg=black
hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type

hi Special guifg=#00979b gui=NONE ctermfg=darkcyan
hi! link SpecialChar Special
hi! link Tag Special
hi! link Delimiter Special
hi! link SpecialComment Special
hi! link Debug Special

hi Underlined guifg=#5050c0 gui=underline ctermbg=darkblue ctermfg=white cterm=underline

" vim
hi link vimFuncName Statement
hi link vimVar Normal
hi link vimOper Normal
hi link vimParenSep Normal
hi link vimMapModKey Special
hi link vimMapMod vimMapModKey
hi link vimAutoEvent Constant
hi vimCommentTitle gui=italic

" python
hi link pythonInclude Statement
hi link pythonBuiltin Statement
hi link pythonConditional Statement
hi link pythonRepeat Statement

" ruby
hi link rubyInclude Statement
hi link rubyModule Statement
hi link rubyClass Statement
hi link rubyMacro Statement
hi link rubyStringDelimiter String
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
hi link elixirStringDelimiter String
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

" clojure
hi link clojureMacro Statement
hi link clojureDefine Statement
hi link clojureFunc Statement

" dos batch
hi link dosbatchImplicit Statement

" markdown
hi link markdownH1 Title
hi link markdownH2 Title
hi link markdownH3 Title
hi link markdownH4 Title
hi link markdownH5 Title
hi link markdownH6 Title
hi link markdownHeadingDelimiter Constant
hi link markdownListMarker Constant
hi link markdownCode Constant
hi link markdownCodeDelimiter markdownCode

" asciidoctor
hi link asciidoctorListMarker Constant

"" Diff
hi diffAdd guibg=#c9f9c9
hi diffChange guibg=#f9f9c9
hi diffText guibg=#f9d999 guifg=NONE gui=NONE
hi diffDelete guibg=#f9c9c9 guifg=#707070 gui=NONE

"" fugitive
hi fugitiveHeader guibg=#ffffff guifg=#000000 gui=bold
hi fugitiveHeading guibg=#ffffff guifg=#000000 gui=bold
hi gitKeyword guibg=#ffffff guifg=#000000 gui=bold
hi link gitIdentityKeyword gitKeyword
hi link fugitiveModifier Statement
hi link fugitiveSymbolicRef Constant
hi link diffIndexLine Comment
hi link diffFile Title
hi link diffNewFile Title
hi link diffLine fugitiveHeading
hi link diffSubName diffLine
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
hi link netrwDateSep Normal
hi link netrwTimeSep Normal
hi link netrwExe Constant
hi link netrwDir Directory

"" quickfix
hi link qfFilename Comment
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
	execute 'hi Lf_hl_'.lf_mode.'_stlName guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlMode guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlCategory guibg=#2c2c2c guifg=#c0c0c0 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlCwd guibg=#2c2c2c guifg=#ffffff gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator0 guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator1 guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator2 guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator3 guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator4 guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator5 guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlLineInfo guibg=#2c2c2c guifg=#ffffff gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlNameOnlyMode guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlRegexMode guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlFullPathMode guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlFuzzyMode guibg=#2c2c2c guifg=#505050 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlTotal guibg=#2c2c2c guifg=#ffffff gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlBlank guibg=#2c2c2c guifg=#ffffff gui=NONE'
endfor

hi link Lf_hl_bufDirname Comment
hi link Lf_hl_funcDirname Comment
hi link Lf_hl_rgFilename Comment
hi link Lf_hl_rgTagFile Comment

"" CtrlP
hi CtrlPMatch guifg=#1540AD gui=bold

