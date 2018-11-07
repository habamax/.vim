" Vim syntax file
" Language:     asciidoctor
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Filenames:    *.adoc
" Last Change:  2018-11-01

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'asciidoctor'
endif

if !exists('g:asciidoctor_fenced_languages')
  let g:asciidoctor_fenced_languages = []
endif
for s:type in map(copy(g:asciidoctor_fenced_languages),'matchstr(v:val,"[^=]*$")')
  if s:type =~ '\.'
    let b:{matchstr(s:type,'[^.]*')}_subtype = matchstr(s:type,'\.\zs.*')
  endif
  exe 'syn include @asciidoctorHighlight'.substitute(s:type,'\.','','g').' syntax/'.matchstr(s:type,'[^.]*').'.vim'
  unlet! b:current_syntax
endfor
unlet! s:type

syn sync minlines=10
syn case ignore

syn match asciidoctorValid '[<>]\c[a-z/$!]\@!'
syn match asciidoctorValid '&\%(#\=\w*;\)\@!'

syn match asciidoctorLineStart "^[<@]\@!" nextgroup=@asciidoctorBlock
syn match asciidoctorComment "^//.*$"
syn match asciidoctorOption "^:[[:alnum:]-]\{-}:.*$"

syn cluster asciidoctorBlock contains=asciidoctorTitle,asciidoctorH1,asciidoctorH2,asciidoctorH3,asciidoctorH4,asciidoctorH5,asciidoctorH6,asciidoctorBlockquote,asciidoctorListMarker,asciidoctorOrderedListMarker,asciidoctorCodeBlock
syn cluster asciidoctorInline contains=asciidoctorLineBreak,asciidoctorLinkText,asciidoctorItalic,asciidoctorBold,asciidoctorCode,asciidoctorError

syn match asciidoctorH1 "^.\+\n=\+$" contained contains=@asciidoctorInline,asciidoctorHeadingRule,asciidoctorAutomaticLink
syn match asciidoctorH2 "^.\+\n-\+$" contained contains=@asciidoctorInline,asciidoctorHeadingRule,asciidoctorAutomaticLink

syn match asciidoctorHeadingRule "^[=-]\+$" contained

syn match asciidoctorTitle "^=\s.*$"
syn match asciidoctorH1 "^==\s.*$"
syn match asciidoctorH2 "^===\s.*$"
syn match asciidoctorH3 "^====\s.*$"
syn match asciidoctorH4 "^=====\s.*$"
syn match asciidoctorH5 "^======\s.*$"
syn match asciidoctorH6 "^=======\s.*$"

" syn match asciidoctorBlockquote ">\%(\s\|$\)" contained nextgroup=@asciidoctorBlock

" syn region asciidoctorCodeBlock start="    \|\t" end="$" contained

" TODO: real nesting
syn match asciidoctorListMarker "\s*\(-\|\*\+\|\.\+\)\%(\s\+\S\)\@=" contained
syn match asciidoctorOrderedListMarker "\s*\d\+\.\%(\s\+\S\)\@=" contained

syn match asciidoctorDefList "^\S.\{-}::"
syn match asciidoctorCaption "^\..\+$"

" syn match asciidoctorLineBreak " \{2,\}$"

" syn region asciidoctorIdDeclaration matchgroup=asciidoctorLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=asciidoctorUrl skipwhite
" syn match asciidoctorUrl "\S\+" nextgroup=asciidoctorUrlTitle skipwhite contained
" syn region asciidoctorUrl matchgroup=asciidoctorUrlDelimiter start="<" end=">" oneline keepend nextgroup=asciidoctorUrlTitle skipwhite contained
" syn region asciidoctorUrlTitle matchgroup=asciidoctorUrlTitleDelimiter start=+"+ end=+"+ keepend contained
" syn region asciidoctorUrlTitle matchgroup=asciidoctorUrlTitleDelimiter start=+'+ end=+'+ keepend contained
" syn region asciidoctorUrlTitle matchgroup=asciidoctorUrlTitleDelimiter start=+(+ end=+)+ keepend contained

" syn region asciidoctorLinkText matchgroup=asciidoctorLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=asciidoctorLink,asciidoctorId skipwhite contains=@asciidoctorInline,asciidoctorLineStart
" syn region asciidoctorLink matchgroup=asciidoctorLinkDelimiter start="(" end=")" contains=asciidoctorUrl keepend contained
" syn region asciidoctorId matchgroup=asciidoctorIdDelimiter start="\[" end="\]" keepend contained
" syn region asciidoctorAutomaticLink matchgroup=asciidoctorUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

syn match asciidoctorBold /\(^\|\s\)\zs\*\S.\{-}\S\*\ze\_s/ keepend contains=asciidoctorLineStart,asciidoctorItalic
syn match asciidoctorBold /\*\*\S.\{-}\S\*\*/ keepend contains=asciidoctorLineStart,asciidoctorItalic
syn match asciidoctorItalic /\(^\|\s\)\zs_\S.\{-}\S_\ze\_s/ keepend contains=asciidoctorLineStart,asciidoctorItalic
syn match asciidoctorItalic /__\S.\{-}\S__/ keepend contains=asciidoctorLineStart,asciidoctorItalic
syn match asciidoctorBoldItalic /\(^\|\s\)\zs\*_\S.\{-}\S_\*\ze\_s/ keepend contains=asciidoctorLineStart
syn match asciidoctorBoldItalic /\*\*_\S.\{-}\S_\*\*/ keepend contains=asciidoctorLineStart
syn match asciidoctorCode /\(^\|\s\)\zs`\S.\{-}\S`\ze\_s/ keepend contains=asciidoctorLineStart,asciidoctorItalic,asciidoctorBold
syn match asciidoctorCode /``\S.\{-}\S``/ keepend contains=asciidoctorLineStart,asciidoctorItalic,asciidoctorBold


if main_syntax ==# 'asciidoctor'
  for s:type in g:asciidoctor_fenced_languages
    exe 'syn region asciidoctorHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=asciidoctorCodeDelimiter start="^\s*```\s*'.matchstr(s:type,'[^=]*').'\>.*$" end="^\s*```\ze\s*$" keepend contains=@asciidoctorHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\.','','g')
  endfor
  unlet! s:type
endif

" syn match asciidoctorEscape "\\[][\\`*_{}()<>#+.!-]"
" syn match asciidoctorError "\w\@<=_\w\@="

hi def link asciidoctorTitle                 Title
hi def link asciidoctorH1                    Title
hi def link asciidoctorH2                    Title
hi def link asciidoctorH3                    Title
hi def link asciidoctorH4                    Title
hi def link asciidoctorH5                    Title
hi def link asciidoctorH6                    Title
hi def link asciidoctorHeadingRule           Delimiter
hi def link asciidoctorListMarker            Delimiter
hi def link asciidoctorOrderedListMarker     asciidoctorListMarker
hi def link asciidoctorBlockquote            Comment
hi def link asciidoctorComment               Comment

hi def link asciidoctorLinkText              htmlLink
hi def link asciidoctorIdDeclaration         Typedef
hi def link asciidoctorId                    Type
hi def link asciidoctorAutomaticLink         asciidoctorUrl
hi def link asciidoctorUrl                   Float
hi def link asciidoctorUrlTitle              String
hi def link asciidoctorIdDelimiter           asciidoctorLinkDelimiter
hi def link asciidoctorUrlDelimiter          htmlTag
hi def link asciidoctorUrlTitleDelimiter     Delimiter

hi asciidoctorBold                           gui=bold cterm=bold
hi asciidoctorItalic                         gui=italic cterm=italic
hi asciidoctorBoldItalic                     gui=bold,italic cterm=bold,italic
hi def link asciidoctorDefList               asciidoctorBold
hi def link asciidoctorCode                  PreProc
hi def link asciidoctorOption                PreProc
hi def link asciidoctorCaption               asciidoctorItalic

" hi def link asciidoctorEscape                Special
" hi def link asciidoctorError                 Error

let b:current_syntax = "asciidoctor"
if main_syntax ==# 'asciidoctor'
  unlet main_syntax
endif

" vim:set sw=2:
