" Vim syntax file
" Maintainer:  Maxim Kim <habamax@gmail.com>
" Language:    Typst
" Last Change: 2026-06-26
" Based on the syntax file from https://github.com/kaarmu/typst.vim

if exists('b:current_syntax')
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax spell toplevel
syntax sync minlines=300

syntax cluster typstExpr
      \ contains=typstExprCodeBlock
      \ ,typstExprContentBlock
      \ ,typstExprBraces
      \ ,typstExprCommand
      \ ,typstExprVar
      \ ,typstExprFunc
      \ ,typstExprString
      \ ,@typstComment
      " \ ,typstExprLet
      " \ ,typstExprFor
      " \ ,typstExprIf

syntax match typstExprStart /#/ nextgroup=@typstExpr,typstExprBareVar
hi link typstExprStart Special

syntax iskeyword @,48-57,192-255,_,-

syntax match typstExprVar /\k\+/
      \ skipwhite
      \ contained
      \ nextgroup=typstExprOp
syntax region typstExprBraces
      \ skipwhite
      \ contained
      \ contains=@typstExpr
      \ nextgroup=typstExprOp
      \ start=/ (/
      \ skip=/(.*)/
      \ end=/)/
syntax match typstExprOp /\%(=[=>]\)\|\%([-+*/<>!=]=\)\|in\>\|and\>\|or\>\|\%(not\%(\s\+in\>\)\?\)\|[<=>\-+*/]/
      \ skipwhite
      \ contained
      \ nextgroup=@typstExpr


syntax match typstExprBareVar /\k\+/ skipwhite contained


syntax match typstExprCommand /let\|set\|for\|if\|show\|import/
      \ skipwhite
      \ contained
      \ nextgroup=@typstExpr

syntax region typstExprCodeBlock
      \ skipwhite
      \ contained
      \ contains=@typstExpr
      \ start=/{/
      \ end=/}/

syntax region typstExprContentBlock
      \ skipwhite
      \ contained
      \ contains=@typstMarkup,@typstExpr,typstExprStart
      \ nextgroup=typstExprOp,typstExprContentBlock
      \ matchgroup=NONE
      \ start=/\[/
      \ end=/\]/

syntax region typstExprFunc
      \ transparent
      \ skipwhite skipempty
      \ extend
      \ contained
      \ contains=@typstExpr
      \ nextgroup=@typstExpr
      \ matchgroup=typstExprFunc
      \ start=/\k\+\(\.\k\+\)*(\@=/
      \ end=/)/

hi link typstExprOp Operator
hi link typstExprBareVar Identifier
hi link typstExprEmbeddedBareVar Identifier
hi link typstExprFunc Function
hi link typstExprCommand Statement

" syntax keyword typstExprKeyword
"       \ contained
"       \ let
"       \ if else
"       \ while for
"       \ not in and or return

syntax region typstExprString
      \ contained
      \ start=/"/ skip=/\v\\\\|\\"/ end=/"/
      \ contains=@Spell

hi link typstExprString String

" syntax cluster typstCodeIdentifiers
"       \ contains=typstCodeIdentifier
"       \ ,typstCodeFieldAccess
" " syntax match typstCodeIdentifier
" "       \ contained
" "       \ /\v\w\k*>(<%(let|set|show|import|include))@<![\.\[\(]@!/
" " syntax match typstCodeIdentifier
" "       \ contained
" "       \ /\v\w\k*>(<%(let|set|show|import|include))@<![\.\[\(]@!/
" syntax match typstCodeFieldAccess
"       \ contained
"       \ /\v\w\k*>(<%(let|set|show|import|include))@<!\.[\[\(]@!/
"       \ nextgroup=typstCodeFieldAccess,typstCodeFunction

" syntax match typstCodeFunction
"       \ contained
"       \ /\v\w\k*>(<%(let|set|show|import|include))@<![\(\[]@=/
"       \ nextgroup=typstCodeFunctionArgument

" syntax cluster typstCodeConstants
"       \ contains=typstCodeConstant
"       \ ,typstCodeNumberInteger
"       \ ,typstCodeNumberFloat
"       \ ,typstCodeNumberLength
"       \ ,typstCodeNumberAngle
"       \ ,typstCodeNumberRatio
"       \ ,typstCodeNumberFraction
"       \ ,typstCodeString
"       \ ,typstCodeLabel
" syntax match typstCodeConstant
"       \ contained
"       \ /\v<%(none|auto|true|false)-@!>/
" syntax match typstCodeNumberInteger
"       \ contained
"       \ /\v<\d+>/

" syntax match typstCodeNumberFloat
"       \ contained
"       \ /\v<\d+\.\d*>/
" syntax match typstCodeNumberLength
"       \ contained
"       \ /\v<\d+(\.\d*)?(pt|mm|cm|in|em)>/
" syntax match typstCodeNumberAngle
"       \ contained
"       \ /\v<\d+(\.\d*)?(deg|rad)>/
" syntax match typstCodeNumberRatio
"       \ contained
"       \ /\v<\d+(\.\d*)?\%/
" syntax match typstCodeNumberFraction
"       \ contained
"       \ /\v<\d+(\.\d*)?fr>/
" syntax match typstCodeLabel
"       \ contained
"       \ /\v\<\K%(\k*-*)*\>/

" syntax region typstCodeDollar
"       \ contained
"       \ matchgroup=Number start=/\\\@<!\$/ end=/\\\@<!\$/
"       \ contains=@typstMath


syntax cluster typstMarkup
      \ contains=typstMarkupRawInline
      \ ,typstMarkupRawBlock
      \ ,typstMarkupLabel
      \ ,typstMarkupReference
      \ ,typstMarkupUrl
      \ ,typstMarkupHeading
      \ ,typstMarkupBulletList
      \ ,typstMarkupEnumList
      \ ,typstMarkupTermList
      \ ,typstMarkupBold
      \ ,typstMarkupItalic
      \ ,typstMarkupBoldItalic
      \ ,typstMarkupLinebreak
      \ ,typstMarkupNonbreakingSpace
      \ ,typstMarkupShy
      \ ,typstMarkupDash
      \ ,typstMarkupEllipsis

syntax region typstMarkupRawInline
      \ matchgroup=typstMarkupRawInlineDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\@1<=`[^`]\@1=+
      \ skip=/\\`/
      \ end=+`+

syntax region typstMarkupRawBlock
      \ matchgroup=Macro start=/```\w*/
      \ matchgroup=Macro end=/```/ keepend
syntax region typstMarkupCodeBlockTypst
      \ matchgroup=Macro start=/```typst/
      \ matchgroup=Macro end=/```/ contains=@typstCode keepend
      \ concealends

for s:name in get(g:, 'typst_embedded_languages', [])
    let s:include = ['syntax include'
                \   ,'@typstEmbedded_'..s:name
                \   ,'syntax/'..s:name..'.vim']
    let s:rule = ['syn region'
                \ ,"typstMarkupRawBlock_"..s:name
                \ ,'matchgroup=Macro'
                \ ,'start=/```'..s:name..'\>/ end=/```/' 
                \ ,'contains=@typstEmbedded_'..s:name 
                \ ,'keepend'
                \ ,'concealends']

    execute 'silent! ' .. join(s:include, ' ')
    unlet! b:current_syntax
    execute join(s:rule, ' ')
endfor

" Label & Reference
syntax match typstMarkupLabel
      \ /\v\<\K%(\k*-*)*\>/
syntax match typstMarkupReference
      \ /\v\@\K%(\k*-*)*/

syntax match typstMarkupUrl
      \ #\v\w+://\S*#

syntax region typstMarkupHeading
      \ matchgroup=typstMarkupHeadingDelimiter
      \ start=/^\s*\zs=\{1,6}\s/
      \ end=/$/ keepend oneline
      \ contains=typstMarkupLabel,@Spell

syntax match typstMarkupBulletList
      \ /\v^\s*-\s+/
syntax match typstMarkupEnumList
      \ /\v^\s*(\+|\d+\.)\s+/
syntax region typstMarkupTermList
      \ matchgroup=typstMarkupTermListDelimiter
      \ start=/\v^\s*\/\s/
      \ skip=/\\:/
      \ end=/:/
      \ oneline contains=@typstMarkup

syn region typstMarkupBold
      \ start=+\%(^\|[\[[:space:]-:/]\)\@1<=\*[^*]\@1=+
      \ skip=+\\\*+
      \ end=+\*\($\|[[:space:]-.,:;!?"'/\\>)\]}]\)\@1=+
      \ concealends contains=typstMarkupLabel,@Spell
syn region typstMarkupItalic
      \ start=+\%(^\|[\[[:space:]-:/]\)\@1<=_[^_]\@1=+
      \ skip=+\\_+
      \ end=+_\($\|[[:space:]-.,:;!?"'/\\>)\]}]\)\@1=+
      \ concealends contains=typstMarkupLabel,@Spell
syn region typstMarkupBoldItalic
      \ start=+\%(^\|[\[[:space:]-:/]\)\@1<=\*_[^*_]\@1=+
      \ skip=+\\\*_+
      \ end=+_\*\($\|[[:space:]-.,:;!?"'/\\>)\]}]\)\@1=+
      \ concealends contains=typstMarkupLabel,@Spell
syn region typstMarkupBoldItalic
      \ start=+\%(^\|[[:space:]-:/]\)\@1<=_\*[^*_]\@1=+
      \ skip=+\\_\*+
      \ end=+\*_\($\|[[:space:]-.,:;!?"'/\\>)\]}]\)\@1=+
      \ concealends contains=typstMarkupLabel,@Spell

" syntax match typstMarkupLinebreak
"       \ /\%([^\\]\|^\)\@1<=\\\%(\s\|$\)/
" syntax match typstMarkupNonbreakingSpace
"       \ /\~/
" syntax match typstMarkupShy
"       \ /-?/

" syntax match typstMarkupDash
"       \ /-\{2,3}/
" syntax match typstMarkupEllipsis
"       \ /\.\.\./

syntax region typstMarkupMath
      \ matchgroup=typstMarkupDollar start=/\\\@<!\$/ end=/\\\@<!\$/
      \ contains=@typstMath

" Math
syntax cluster typstMath
      \ contains=@typstHashtag
      \ ,typstMathIdentifier
      \ ,typstMathFunction
      \ ,typstMathNumber
      \ ,typstMathSymbol
      \ ,typstMathBold
      \ ,typstMathScripts
      \ ,typstMathQuote
      \ ,@typstComment

syntax match typstMathIdentifier
      \ /\a\a\+/
      \ contained
syntax match typstMathFunction
      \ /\a\a\+\ze(/
      \ contained
syntax match typstMathNumber
      \ /\<\d\+\>/
      \ contained
syntax region typstMathQuote
      \ matchgroup=String start=/"/ skip=/\\"/ end=/"/
      \ contained


syntax cluster typstComment
      \ contains=typstCommentBlock,typstCommentLine
syntax region typstCommentBlock
      \ start="/\*" end="\*/" keepend
      \ contains=typstCommentTodo,@Spell
syntax match typstCommentLine
      \ #//.*#
      \ contains=typstCommentTodo,@Spell
syntax keyword typstCommentTodo
      \ contained
      \ TODO FIXME XXX TBD


hi link typstScriptKeyword Statement

hi def link typstMathIdentifier Identifier
hi def link typstMathFunction Statement
hi def link typstMathNumber Number
hi def link typstMathSymbol Statement
hi def link typstCommentBlock Comment
hi def link typstCommentLine Comment
hi def link typstCommentTodo Todo
hi def link typstCodeKeyword Statement
hi def link typstCodeConstant Constant
hi def link typstCodeNumberInteger Number
hi def link typstCodeNumberFloat Number
hi def link typstCodeNumberLength Number
hi def link typstCodeNumberAngle Number
hi def link typstCodeNumberRatio Number
hi def link typstCodeNumberFraction Number
hi def link typstCodeString String
hi def link typstCodeLabel Structure
hi def link typstCodeStatementWord Statement
hi def link typstCodeIdentifier Type
hi def link typstCodeFieldAccess Identifier
hi def link typstCodeFunction Function
hi def link typstHashtagConditional Conditional
hi def link typstHashtagRepeat Repeat
hi def link typstHashtagKeyword Keyword
hi def link typstHashtagConstant Constant
hi def link typstHashtagStatementWord Statement
hi def link typstHashtagIdentifier Identifier
hi def link typstHashtagFieldAccess Identifier
hi def link typstHashtagFunction Function
hi def link typstMarkupRawInlineDelimiter Special
hi def link typstMarkupRawBlock Special
hi def link typstMarkupDollar Special
hi def link typstMarkupLabel PreProc
hi def link typstMarkupReference Special
hi def link typstMarkupBulletList PreProc
hi def link typstMarkupEnumList PreProc
hi def link typstMarkupLinebreak Special
hi def link typstMarkupNonbreakingSpace Special
hi def link typstMarkupShy Special
hi def link typstMarkupDash Special
hi def link typstMarkupEllipsis Special
hi def link typstMarkupTermList Bold
hi def link typstMarkupTermListDelimiter PreProc
hi def link typstMarkupHeading Title
hi def link typstMarkupHeadingDelimiter Type
hi def link typstMarkupUrl Underlined
hi def link typstMarkupBold Bold
hi def link typstMarkupItalic Italic
hi def link typstMarkupBoldItalic BoldItalic

let b:current_syntax = 'typst'

let &cpo = s:cpo_save
unlet s:cpo_save
