" Vim color scheme
"
" Name:       defminus.vim
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT
"
" GUI only `white background` colorscheme.
" There are tons of awesome `dark background` colorschemes and I use them for
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
hi Todo guibg=NONE guifg=#ff0000 gui=bold ctermfg=red

"" UI
hi Statusline guibg=#2c2c2c guifg=#ffffff gui=NONE ctermbg=black ctermfg=white
hi StatuslineNC guibg=#5c5c5c guifg=#cbcbcb gui=NONE ctermbg=black ctermfg=white
hi VertSplit guibg=NONE guifg=#5c5c5c gui=NONE ctermbg=black ctermfg=darkgray
" hi VertSplit guibg=#7c7c7c guifg=#cbcbcb gui=NONE ctermbg=black ctermfg=darkgray
hi WildMenu guibg=#ffff00 guifg=#000000 gui=NONE
hi Folded guibg=#f5f5f5 guifg=#505050 gui=NONE ctermbg=darkgray ctermfg=black
hi FoldColumn guibg=#eaeaea ctermbg=darkgray ctermfg=black
hi CursorLine guibg=#e7efff
hi CursorColumn guibg=#e7efff
hi SignColumn guibg=NONE
hi Pmenu guibg=#eaeaea guifg=#505050 gui=NONE ctermbg=lightgray ctermfg=black
hi PmenuSel guibg=#c0c0c0 guifg=#505050 gui=bold ctermbg=darkgray ctermfg=black

"" Syntax

" generic group-names
" hi Comment guifg=#909090 gui=italic ctermfg=lightgrey
hi Comment guifg=#909090 gui=NONE ctermfg=lightgrey

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

hi Special guifg=#00737b gui=NONE ctermfg=darkcyan
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
hi link vimHiAttrib Constant
hi link vimHiCtermColor Constant
" The same as Constant + italic
" hi vimCommentTitle guifg=#a04327 gui=italic ctermfg=green
hi vimCommentTitle guifg=#a04327 gui=NONE ctermfg=green

" python
hi link pythonInclude Statement
hi link pythonBuiltin Statement
hi link pythonConditional Statement
hi link pythonRepeat Statement
hi link pythonOperator Statement
hi link pythonException Statement

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

" Go
hi link goDirective Statement
hi link goDeclaration Statement
hi link goType Statement
hi link goDeclType Statement
hi link goSignedInts Statement
hi link goConstants Constant
hi link goBuiltins Statement

" C
hi link cInclude Constant
hi link cPreCondit Constant
hi link cDefine Constant
hi link cType Statement
hi link cStructure Statement
hi link cStorageClass Statement

" Cpp
hi link cppStructure Statement
hi link cppModifier Statement
hi link cppType Statement

" TCL
hi link tclProcCommand Statement
hi link tclVarRef Identifier
hi link tcltkWidgetColor Statement

" xml
hi link xmlTagName Statement
hi link xmlTagN Statement
hi link xmlAttrib Constant

" html
hi link htmlTagName Statement
hi link htmlTag Statement
hi link htmlEndTag Statement
hi link htmlArg Constant
hi link htmlSpecialTagName Statement
hi link htmlSpecialChar SpecialChar

" css
hi link cssColor Constant
hi link cssPseudoClassId Identifier
hi link cssClassName Identifier
hi link cssIdentifier Identifier
hi link cssAtRule Identifier

" javascript
hi link javaScriptIdentifier Statement
hi link javaScriptFunction Statement
hi link javaScriptOperator Statement
hi link javaScriptType Identifier
hi link javaScriptNumber Constant

" yaml
hi link yamlBlockMappingKey Statement
hi link yamlKeyValueDelimiter Statement
hi link yamlDocumentStart Comment

" json
hi link jsonKeyword Statement
hi link jsonKeywordMatch Statement
hi link jsonString String
hi link jsonQuote Normal
hi link yamlKeyValueDelimiter Statement

" sql
hi link sqlKeyword Statement

" java
" hi javaCommentTitle guifg=#909090 gui=bold,italic ctermfg=lightgrey
hi javaCommentTitle guifg=#909090 gui=bold ctermfg=lightgrey
hi link javaExternal Statement
hi link javaScopeDecl Statement
hi link javaClassDecl Statement
hi link javaStorageClass Statement
hi link javaType Statement
hi link javaOperator Statement
hi link javaConstant Constant
hi link javaDocTags String
hi link javaDocParam Constant
hi link javaDocSeeTagParam Constant

" c#
hi link csUnspecifiedStatement Statement
hi link csStorage Statement
hi link csModifier Statement
hi link csClass Statement
hi link csType Statement
hi link csOpSymbols Normal
hi link csLogicSymbols Normal

" clojure
hi link clojureMacro Statement
hi link clojureDefine Statement
hi link clojureFunc Statement

" php
hi link phpDocTags String
hi link phpDocCustomTags String
hi link phpStructure Statement
hi link phpInclude Statement
hi link phpStorageClass Statement
hi link phpDefine Statement
hi link phpVarSelector Identifier
hi link phpSpecialFunction Identifier
hi link phpOperator Normal
hi link phpComparison Normal
hi link phpType Constant

" dos batch
hi link dosbatchImplicit Statement

" sh
hi link shSet Statement
hi link shQuote Identifier

" markdown
hi link markdownH1 Title
hi link markdownH2 Title
hi link markdownH3 Title
hi link markdownH4 Title
hi link markdownH5 Title
hi link markdownH6 Title
hi link markdownHeadingDelimiter Constant
hi link markdownListMarker Special
hi link markdownCode Constant
hi link markdownCodeDelimiter markdownCode

" asciidoctor
hi link asciidoctorListMarker Special

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
hi link gitCommitHeader fugitiveHeader
hi link gitCommitSelectedType Constant
hi link gitCommitSelectedFile Normal

"" minpac
hi link minpacName Statement

"" UltiSnips
hi link snipSnippetTrigger Normal
hi link snipMirror Special
hi link snipTabStop Special

"" help
hi link helpHeader Title
hi link helpHeadLine Title
hi link helpHyperTextEntry Statement
hi link helpHyperTextJump Underlined
hi link helpExample Constant
hi link helpURL Underlined
hi helpSectionDelim guifg=#909090
hi link helpOption Constant

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

"" ALE
hi link ALEWarningSign SignColumn
hi link ALEErrorSign WarningMsg
