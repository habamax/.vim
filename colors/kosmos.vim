" Vim color file
"
" Description:
" Black and Gray colorscheme with limited syntax highlighting focusing on:
" - keywords -- a bit of standout (just white)
" - strings -- clearly visible, to be sure quotes are closed (greenish)
" - comments -- should standout of other source code (kind of cyanish).
"
" File: kosmos.vim
" URL: github.com/habamax/kosmos.vim
" Maintainer: Maxim Kim
" License: MIT
"
" Permission is hereby granted, free of charge, to any per‐
" son obtaining a copy of this software and associated doc‐
" umentation files (the “Software”), to deal in the Soft‐
" ware without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distrib‐
" ute, sublicense, and/or sell copies of the Software, and
" to permit persons to whom the Software is furnished to do
" so, subject to the following conditions:
"
" The above copyright notice and this permission notice
" shall be included in all copies or substantial portions
" of the Software.
"
" THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
" KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
" THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICU‐
" LAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CON‐
" TRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON‐
" NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
" TODO:
" 1. terminal colors
" 2. quickfix highlight line
" 3. further markdown
" 5. more latex
" 9. diff

" GUI color definitions
let s:gui00 = "000000" " MASTER COLOR: background
let s:gui01 = "bdbdbd" " MASTER COLOR: foreground
let s:gui02 = "ffffff" " MASTER COLOR: keywords and stuff
let s:gui03 = "73bd7a" " MASTER COLOR: strings
let s:gui04 = "5797a0" " MASTER COLOR: comments
let s:gui05 = "839191" " MASTER COLOR: visual
let s:gui06 = "fff68f" " MASTER COLOR: incsearch
let s:gui07 = "606020" " MASTER COLOR: incsearch bg
let s:gui08 = "40e0d0" " MASTER COLOR: search fg
let s:gui09 = "206060" " MASTER COLOR: search bg
let s:gui0A = "3f5f5f" " MASTER COLOR: Statusline
let s:gui0B = "393030" " MASTER COLOR: NonText
let s:gui0C = "707070" " MASTER COLOR: inactive text/dimmed text
let s:gui0D = "1a1d1d" " MASTER COLOR: sidebars/statusInactive
let s:gui0E = "f07070" " MASTER COLOR: error bg
let s:gui0F = "90a0bd" " MASTER COLOR: url

" FIXME: not ready yet at all
" Terminal color definitions
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
" FIXME: check with base16 what is this all about
if exists('base16colorspace') && base16colorspace == "256"
	let s:cterm01 = "18"
	let s:cterm02 = "19"
	let s:cterm04 = "20"
	let s:cterm06 = "21"
	let s:cterm09 = "16"
	let s:cterm0F = "17"
else
	let s:cterm01 = "10"
	let s:cterm02 = "11"
	let s:cterm04 = "12"
	let s:cterm06 = "13"
	let s:cterm09 = "09"
	let s:cterm0F = "14"
endif

" Theme setup
hi clear
syntax reset
let g:colors_name = "kosmos"

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
	if a:guifg != ""
		exec "hi " . a:group . " guifg=#" . a:guifg
	endif
	if a:guibg != ""
		exec "hi " . a:group . " guibg=#" . a:guibg
	endif
	if a:ctermfg != ""
		exec "hi " . a:group . " ctermfg=" . a:ctermfg
	endif
	if a:ctermbg != ""
		exec "hi " . a:group . " ctermbg=" . a:ctermbg
	endif
	if a:attr != ""
		exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
	endif
	if a:guisp != ""
		exec "hi " . a:group . " guisp=#" . a:guisp
	endif
endfun

" Vim editor colors
call <sid>hi("Bold", "", "", "", "", "bold", "")
call <sid>hi("Debug", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Directory", s:gui02, "", s:cterm0D, "", "", "")
call <sid>hi("Error", s:gui02, s:gui0E, s:cterm00, s:cterm08, "", "")
call <sid>hi("ErrorMsg", s:gui0E, s:gui00, s:cterm08, s:cterm00, "", "")
call <sid>hi("Exception", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("FoldColumn", s:gui0C, s:gui0D, s:cterm0C, s:cterm0D, "", "")
call <sid>hi("Folded", s:gui0C, s:gui0D, s:cterm03, s:cterm01, "", "")
call <sid>hi("IncSearch", s:gui06, s:gui07, s:cterm01, s:cterm0A, "bold,underline", "")
call <sid>hi("Italic", "", "", "", "", "none", "")
call <sid>hi("Macro", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("MatchParen", s:gui00, s:gui03, s:cterm00, s:cterm03, "", "")
call <sid>hi("ModeMsg", s:gui01, "", s:cterm0B, "", "", "")
call <sid>hi("MoreMsg", s:gui02, "", s:cterm0B, "", "", "")
call <sid>hi("Question", s:gui01, "", s:cterm0D, "", "", "")
call <sid>hi("Search", s:gui08, s:gui09, s:cterm01, s:cterm0A, " bold,underline", "")
call <sid>hi("SpecialKey", s:gui0B, s:gui00, s:cterm0B, s:cterm00, "none", "")
call <sid>hi("TooLong", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Underlined", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Visual", s:gui00, s:gui05, s:cterm00, s:cterm05, "", "")
call <sid>hi("VisualNOS", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("WarningMsg", s:gui01, "", s:cterm01, "", "", "")
call <sid>hi("WildMenu", s:gui00, s:gui05, s:cterm00, s:cterm05, "none", "")
call <sid>hi("Title", s:gui02, "", s:cterm02, "", "bold", "")
call <sid>hi("Conceal", s:gui0C, s:gui00, s:cterm0C, s:cterm00, "", "")
call <sid>hi("Cursor", s:gui00, s:gui02, s:cterm00, s:cterm02, "", "")
call <sid>hi("lCursor", s:gui00, s:gui0E, s:cterm00, s:cterm0E, "", "")
call <sid>hi("NonText", s:gui0B, s:gui00, s:cterm0B, s:cterm00, "none", "")
call <sid>hi("Normal", s:gui01, s:gui00, s:cterm01, s:cterm00, "", "")
call <sid>hi("LineNr", s:gui05, s:gui0D, s:cterm03, s:cterm0D, "", "")
call <sid>hi("SignColumn", s:gui03, s:gui0D, s:cterm03, s:cterm0D, "", "")
call <sid>hi("StatusLine", s:gui02, s:gui0A, s:cterm04, s:cterm02, "none", "")
call <sid>hi("StatusLineNC", s:gui01, s:gui0D, s:cterm03, s:cterm01, "none", "")
call <sid>hi("VertSplit", s:gui0C, s:gui0D, s:cterm02, s:cterm02, "none", "")
call <sid>hi("ColorColumn", "", s:gui09, "", s:cterm01, "none", "")
call <sid>hi("CursorColumn", "", s:gui0D, "", s:cterm01, "none", "")
call <sid>hi("CursorLine", "", s:gui0D, "", s:cterm0F, "none", "")
call <sid>hi("CursorLineNr", s:gui05, "", s:cterm03, s:cterm01, "bold", "")
call <sid>hi("PMenu", s:gui04, s:gui0D, s:cterm04, s:cterm0D, "none", "")
call <sid>hi("PMenuSel", s:gui00, s:gui04, s:cterm00, s:cterm04, "", "")
call <sid>hi("PMenuSbar", "", s:gui0C, s:cterm00, s:cterm04, "", "")
call <sid>hi("PMenuThumb", "", s:gui01, s:cterm00, s:cterm04, "", "")
call <sid>hi("TabLine", s:gui04, s:gui0D, s:cterm03, s:cterm01, "none", "")
call <sid>hi("TabLineFill", s:gui04, s:gui0D, s:cterm03, s:cterm01, "none", "")
call <sid>hi("TabLineSel", s:gui02, s:gui04, s:cterm0B, s:cterm01, "none", "")

" Standard syntax highlighting
call <sid>hi("Boolean", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Character", s:gui03, "", s:cterm03, "", "none", "")
call <sid>hi("Comment", s:gui04, "", s:cterm04, "", "none", "")
call <sid>hi("Conditional", s:gui02, "", s:cterm02, "", "none", "")
call <sid>hi("Constant", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Define", s:gui02, "", s:cterm02, "", "none", "")
call <sid>hi("Delimiter", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Float", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Function", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Identifier", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Include", s:gui02, "", s:cterm02, "", "none", "")
call <sid>hi("Keyword", s:gui02, "", s:cterm02, "", "none", "")
call <sid>hi("Label", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Number", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Operator", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("PreProc", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Repeat", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Special", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("SpecialChar", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Statement", s:gui02, "", s:cterm02, "", "none", "")
call <sid>hi("StorageClass", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("String", s:gui03, "", s:cterm03, "", "none", "")
call <sid>hi("Structure", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Tag", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Todo", s:gui05, s:gui00, s:cterm02, s:cterm00, "bold", "")
call <sid>hi("Type", s:gui01, "", s:cterm01, "", "none", "")
call <sid>hi("Typedef", s:gui01, "", s:cterm01, "", "none", "")

" VIM highlighting
call <sid>hi("vimNotation", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("vimBracket", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("helpHyperTextJump", s:gui0F, "", s:cterm0C, "", "underline", "")
call <sid>hi("helpSpecial", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("vimMapModKey", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("helpOption", s:gui02, "", s:cterm0C, "", "none", "")

" CSS highlighting
call <sid>hi("cssBraces", s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("cssClassName", s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("cssColor", s:gui0C, "", s:cterm0C, "", "", "")

" Latex highlighting
call <sid>hi("plaintexControlSequence", s:gui02, "", s:cterm05, "", "", "")
call <sid>hi("initexJobCommand", s:gui02, "", s:cterm05, "", "", "")
call <sid>hi("texTitle", s:gui02, "", s:cterm05, "", "bold", "")
call <sid>hi("texSection", s:gui02, "", s:cterm05, "", "", "")
call <sid>hi("texBoldStyle", s:gui01, "", s:cterm05, "", "bold", "")
call <sid>hi("texItalStyle", s:gui01, "", s:cterm05, "", "italic", "")
call <sid>hi("texTypeSize", s:gui02, "", s:cterm05, "", "", "")

" Diff highlighting
call <sid>hi("DiffAdd", s:gui0B, s:gui01, s:cterm0B, s:cterm01, "", "")
call <sid>hi("DiffChange", s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("DiffDelete", s:gui08, s:gui01, s:cterm08, s:cterm01, "", "")
call <sid>hi("DiffText", s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("DiffAdded", s:gui0B, s:gui00, s:cterm0B, s:cterm00, "", "")
call <sid>hi("DiffFile", s:gui08, s:gui00, s:cterm08, s:cterm00, "", "")
call <sid>hi("DiffNewFile", s:gui0B, s:gui00, s:cterm0B, s:cterm00, "", "")
call <sid>hi("DiffLine", s:gui0D, s:gui00, s:cterm0D, s:cterm00, "", "")
call <sid>hi("DiffRemoved", s:gui08, s:gui00, s:cterm08, s:cterm00, "", "")

" Git highlighting
call <sid>hi("gitCommitOverflow", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("gitCommitSummary", s:gui01, "", s:cterm0B, "", "bold", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd", s:gui03, s:gui0D, s:cterm03, s:cterm0D, "", "")
call <sid>hi("GitGutterChange", s:gui06, s:gui0D, s:cterm06, s:cterm0D, "", "")
call <sid>hi("GitGutterDelete", s:gui0E, s:gui0D, s:cterm0E, s:cterm0D, "", "")
call <sid>hi("GitGutterChangeDelete", s:gui0E, s:gui0D, s:cterm0E, s:cterm0D, "", "")

" HTML highlighting
call <sid>hi("htmlBold", "", "", "", "", "bold", "")
call <sid>hi("htmlItalic", "", "", "", "", "italic", "")
call <sid>hi("htmlBoldItalic", "", "", "", "", "bold,italic", "")
call <sid>hi("htmlEndTag", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("htmlTag", s:gui0C, "", s:cterm0C, "", "", "")

" XML highlighting
call <sid>hi("xmlTag", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("xmlTagName", s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("xmlEndTag", s:gui0C, "", s:cterm0C, "", "", "")

" Markdown highlighting
call <sid>hi("markdownCode", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("markdownCodeBlock", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("markdownHeadingDelimiter", s:gui0C, "", s:cterm0D, "", "", "")
call <sid>hi("markdownHeadingRule", s:gui0C, "", s:cterm0D, "", "", "")

" Pandoc highlighting
call <sid>hi("yamlDocumentStart", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("yamlDocumentEnd", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("yamlBlockMappingKey", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("yamlKeyValueDelimiter", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocAtxStart", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocUListItemBullet", s:gui02, "", s:cterm0B, "", "", "")
call <sid>hi("pandocDelimitedCodeBlock", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocDelimitedCodeBlockEnd", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocCodeBlock", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocNoFormatted", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocOperator", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("pandocEmphasis", "", "", s:cterm0B, "", "italic", "")
call <sid>hi("pandocStrong", "", "", s:cterm0B, "", "bold", "")
call <sid>hi("pandocStrongEmphasis", "", "", s:cterm0B, "", "bold,italic", "")
call <sid>hi("pandocReferenceURL", s:gui0F, "", s:cterm0F, "", "underline", "")
call <sid>hi("pandocReferenceDefinitionAddress", s:gui0F, "", s:cterm0F, "", "underline", "")
call <sid>hi("pandocReferenceDefinitionLabel", s:gui0C, "", s:cterm0F, "", "none", "")

" AsciiDoc highlighting
call <sid>hi("asciidocAttributeEntry", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocListBullet", s:gui02, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocLiteralParagraph", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocListingBlock", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocQuoteBlockDelimiter", s:gui05, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocExampleBlockDelimiter", s:gui05, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocSidebarDelimiter", s:gui05, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocTableDelimiter", s:gui05, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocAdmonition", s:gui06, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocAttributeList", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocTablePrefix", s:gui05, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocBlockTitle", s:gui05, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocQuotedBold", "", "", "", "", "bold", "")
call <sid>hi("asciidocQuotedUnconstrainedBold", "", "", "", "", "bold", "")
call <sid>hi("asciidocQuotedEmphasized", "", "", "", "", "italic", "")
call <sid>hi("asciidocQuotedUnconstrainedEmphasized", "", "", "", "", "italic", "")
call <sid>hi("asciidocQuotedMonospaced2", s:gui0C, "", s:cterm0B, "", "", "")
call <sid>hi("asciidocCallout", s:gui04, "", s:cterm0B, "", "", "")

" Python highlighting
call <sid>hi("pythonOperator", s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonRepeat", s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonDocstring", s:gui04, "", s:cterm04, "", "", "")

" Spelling highlighting
call <sid>hi("SpellBad", "", s:gui00, "", s:cterm00, "undercurl", s:gui0E)
call <sid>hi("SpellLocal", "", s:gui00, "", s:cterm00, "undercurl", s:gui02)
call <sid>hi("SpellCap", "", s:gui00, "", s:cterm00, "undercurl", s:gui06)
call <sid>hi("SpellRare", "", s:gui00, "", s:cterm00, "undercurl", s:gui08)

" Plug
call <sid>hi("plugH2", s:gui02, "", "", s:cterm00, "", "")
call <sid>hi("plugName", s:gui02, "", "", s:cterm00, "", "")
call <sid>hi("plugSha", s:gui03, "", "", s:cterm00, "", "")
call <sid>hi("plugEdge", s:gui0C, "", "", s:cterm00, "", "")

" CtrlP
call <sid>hi("CtrlPMatch", s:gui06, s:gui07, "", s:cterm00, "underline", "")
" call <sid>hi("ctrlpprtbase", s:gui06, s:gui07, "", s:cterm00, "underline", "")
" call <sid>hi("ctrlpbufferpath", s:gui06, s:gui07, "", s:cterm00, "underline", "")


" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03 s:gui04 s:gui05 s:gui06 s:gui07
unlet s:gui08 s:gui09 s:gui0A s:gui0B s:gui0C s:gui0D s:gui0E s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07
unlet s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
