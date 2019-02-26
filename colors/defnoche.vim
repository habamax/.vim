" defnoche.vim -- a GVim colorscheme
"
" Name:       defnoche
" Maintainer: Maxim Kim <habamax@gmail.com>
" License:    MIT, but who cares? This is colorscheme.
"
" Description:
"
" GUI only `black background` colorscheme.
" There are tons of awesome `dark background` colorschemes...
" This is not one of them.
"
" But when the night comes upon you
" Caught unsleep
" You better be prepared
"
" Helpers:
"
" :h 'hl' 
" or
" :h highlight-default 
" to get vim default highlight group names
"
" :h group-name
" to see current syntax highlight of default syntax groups

set background=dark

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'defnoche'

"" Helper color groups
hi DefNocheBold guibg=NONE guifg=#ffffff gui=bold

"" General
hi Normal guibg=#000000 guifg=#d0d0d0 gui=NONE ctermbg=black ctermfg=gray
hi Cursor guibg=#ffffff
hi lCursor guibg=#ff0000
hi NonText guibg=NONE guifg=#303030
hi SpecialKey guibg=NONE guifg=#303030
hi Visual guibg=#103040 guifg=NONE

hi! link Directory DefNocheBold
hi Title guibg=NONE guifg=#f0f035 gui=bold
hi Todo guibg=NONE guifg=#e03045 gui=bold

"" UI
hi Statusline guibg=#5c5c5c guifg=#d0d0d0 gui=NONE ctermbg=black ctermfg=white
hi StatuslineNC guibg=#3c3c3c guifg=#9b9b9b gui=NONE ctermbg=black ctermfg=white
hi VertSplit guibg=NONE guifg=#5c5c5c gui=NONE ctermbg=black ctermfg=darkgray
hi WildMenu guibg=#ffff00 guifg=#000000 gui=NONE
hi Folded guibg=#252525 guifg=#909090 gui=NONE ctermbg=darkgray ctermfg=black
hi! link FoldColumn Folded
hi CursorLine guibg=#353535
hi CursorColumn guibg=#353535
hi LineNr guibg=NONE guifg=#909090
hi CursorLineNr guibg=NONE guifg=#d0d0d0 gui=NONE
hi SignColumn guibg=NONE
hi Pmenu guibg=#555555 guifg=#d0d0d0 gui=NONE
hi PmenuSel guibg=#c0c0c0 guifg=#505050 gui=bold

"" Syntax

" generic group-names
hi Comment guifg=#5e5e5e gui=italic ctermfg=lightgrey
" hi Comment guifg=#909090 gui=NONE ctermfg=lightgrey

hi Constant guifg=#e6a657 gui=NONE
hi String guifg=#49b34e gui=NONE
" hi! link Character Constant
" hi! link Number Constant
" hi! link Boolean Constant
" hi! link Float Constant

hi Identifier guifg=#505050 gui=NONE ctermfg=darkgrey
hi! link Function Identifier

hi Statement guifg=#f070f0 gui=NONE
" hi! link Conditional Statement
" hi! link Repeat Statement
" hi! link Label Statement
" hi! link Operator Statement
" hi! link Keyword Statement
" hi! link Exception Statement

hi PreProc guifg=#d0d0d0 gui=NONE ctermfg=white
" hi! link Include PreProc
" hi! link Define PreProc
" hi! link Macro PreProc
" hi! link PreCondit PreProc

hi Type guifg=#d0d0d0 gui=NONE ctermfg=white
" hi! link StorageClass Type
" hi! link Structure Type
" hi! link Typedef Type

hi Special guifg=#00a3ab gui=NONE ctermfg=darkcyan
" hi! link SpecialChar Special
" hi! link Tag Special
" hi! link Delimiter Special
" hi! link SpecialComment Special
" hi! link Debug Special

hi Underlined guifg=#8798e5 gui=underline

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
hi vimCommentTitle guifg=#e6a657 gui=italic ctermfg=green
" hi vimCommentTitle guifg=#a04327 gui=NONE ctermfg=green

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
hi link elixirOperator Normal

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
hi javaCommentTitle guifg=#5e5e5e gui=bold,italic ctermfg=lightgrey
" hi javaCommentTitle guifg=#909090 gui=bold ctermfg=lightgrey
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
hi diffAdd guibg=#294929
hi diffChange guibg=#4f4719
hi diffText guibg=#2f2f09 guifg=NONE gui=NONE
hi diffDelete guibg=#492929 guifg=#707070 gui=NONE

"" fugitive
hi! link fugitiveHeader DefNocheBold
hi! link fugitiveHeading DefNocheBold
hi! link gitKeyword DefNocheBold
hi link gitIdentityKeyword gitKeyword
hi link fugitiveModifier Statement
hi link fugitiveSymbolicRef Constant
hi link diffIndexLine Comment
hi link diffFile Title
hi link diffNewFile Title
hi link diffLine fugitiveHeading
hi link diffSubName diffLine
hi diffAdded guibg=NONE guifg=#00c000 ctermfg=darkgreen
hi diffRemoved guibg=NONE guifg=#f04749 ctermfg=darkred
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
	execute 'hi Lf_hl_'.lf_mode.'_stlName guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlMode guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlCategory guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlCwd guibg=#5c5c5c guifg=#d0d0d0 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator0 guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator1 guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator2 guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator3 guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator4 guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlSeparator5 guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlLineInfo guibg=#5c5c5c guifg=#d0d0d0 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlNameOnlyMode guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlRegexMode guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlFullPathMode guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlFuzzyMode guibg=#5c5c5c guifg=#909090 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlTotal guibg=#5c5c5c guifg=#d0d0d0 gui=NONE'
	execute 'hi Lf_hl_'.lf_mode.'_stlBlank guibg=#5c5c5c guifg=#d0d0d0 gui=NONE'
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
