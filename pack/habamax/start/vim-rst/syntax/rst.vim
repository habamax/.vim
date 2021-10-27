" Vim reStructuredText syntax file
" Language: reStructuredText document format
" Maintainer: Maxim Kim <habamax@gmail.com>
" Description: Based on https://github.com/marshallward/vim-restructuredtext

if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn cluster rstInlineMarkup contains=rstEmphasis,rstStrongEmphasis,
      \ rstInterpretedText,rstInlineLiteral,rstSubstitutionReference,
      \ rstInlineInternalTarget,rstFootnoteReference,rstHyperlinkReference,
      \ rstStandaloneHyperlink,rstFieldName,rstListItem

syn match rstLineBlock /^\s*|/ contained

let s:listpat = strpart(&l:formatlistpat, 0, strlen(&l:formatlistpat) - 4)
execute 'syn match rstListItem /' . s:listpat . '\ze\s\+/ contains=rstLineBlock'

syn cluster rstTables contains=rstTable,rstSimpleTable
syn region rstTable transparent start='^\n\s*+[-=+]\+' end='^$'
      \ contains=rstTableLines,@rstInlineMarkup
syn match rstTableLines contained display '|\|+\%(=\+\|-\+\)\='
syn match rstSimpleTable
      \ '^\s*\%(===\+\)\%(\s*===\+\)\+\s*$'
syn match rstSimpleTable
      \ '^\s*\%(---\+\)\%(\s*---\+\)\+\s*$'

syn match rstSectionDelimiter contained "\v^([=`:.'"~^_*+#-])\1*\s*$"
syn match rstSection "\v^%(%([=-]{3,}\s+[=-]{3,})\n)@<!\S.*\n([=`:.'"~^_*+#-])\1*$"
      \ contains=rstSectionDelimiter,@Spell
syn match rstSection "\v^%(([=`:.'"~^_*+#-])\1*\n).+\n([=`:.'"~^_*+#-])\2*$"
      \ contains=rstSectionDelimiter,@Spell

syn match rstTransition /^\n[=`:.'"~^_*+#-]\{4,}\s*\n$/

syn match rstDoubleColon /::/ contained

syn region rstLiteralBlock matchgroup=rstDelimiter
      \ start='\(^\z(\s*\).*\)\@<=::\n\s*\n' skip='^\s*$' end='^\(\z1\s\+\)\@!'
      \ contains=@NoSpell

syn region rstQuotedLiteralBlock matchgroup=rstDelimiter
      \ start="::\_s*\n\ze\z([!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]\)"
      \ end='^\z1\@!' contains=@NoSpell

syn region rstDoctestBlock matchgroup=rstDelimiter
      \ start='^\s*>>>\s' end='^\s*$'

syn region rstFieldName start=+^\s*:\ze\S+ skip=+\\:+ end=+\S\zs:\ze\(\s\|$\)+ oneline

syn cluster rstDirectives contains=rstFootnote,rstCitation,
      \ rstHyperlinkTarget,rstExDirective

syn match rstExplicitMarkup '^\s*\.\.\_s'
      \ nextgroup=@rstDirectives,rstComment,rstSubstitutionDefinition

syn region rstComment contained
      \ start=/.*/
      \ skip=+^$+
      \ end=/^\s\@!/

syn region rstFootnote contained matchgroup=rstDirective
      \ start=+\[\%(\d\+\|#\%([[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*\)\=\|\*\)\]\_s+
      \ skip=+^$+
      \ end=+^\s\@!+ contains=@rstInlineMarkup,@NoSpell

syn region rstCitation contained matchgroup=rstDirective
      \ start=+\[[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*\]\_s+
      \ skip=+^$+
      \ end=+^\s\@!+ contains=@rstInlineMarkup,@NoSpell

syn region rstHyperlinkTarget contained contains=rstStandaloneHyperlink matchgroup=rstDirective
      \ start='_\%(_\|[^:\\]*\%(\\.[^:\\]*\)*\):\_s' skip=+^$+ end=+^\s\@!+

syn region rstHyperlinkTarget contained contains=rstStandaloneHyperlink matchgroup=rstDirective
      \ start='_`[^`\\]*\%(\\.[^`\\]*\)*`:\_s' skip=+^$+ end=+^\s\@!+

syn region rstHyperlinkTarget contains=rstStandaloneHyperlink matchgroup=rstDirective
      \ start=+^__\_s+ skip=+^$+ end=+^\s\@!+

syn region rstExDirective contained transparent matchgroup=rstDirective
      \ start=+[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*\ze::\_s+
      \ skip=+^$+
      \ end=+^\s\@!+ contains=rstDoubleColon,@rstInlineMarkup,@rstTables


syn match rstSubstitutionDefinition contained /|.*|\_s\+/
      \ nextgroup=@rstDirectives

" Inline markup recognition rules
" https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#inline-markup
syn region rstStrongEmphasis matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs\*\*\ze[^[:space:]]+
      \ skip=+\\\*+
      \ end=+\S\zs\*\*\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ concealends

syn region rstEmphasis matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs\*\ze[^*[:space:]]+
      \ skip=+\\\*+
      \ end=+\S\zs\*\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ concealends

syn region rstInlineLiteral matchgroup=rstDelimiter
      \ start=+\(^\|[[:space:]-:/]\)\zs``\ze\S+
      \ end=+\S\zs``\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ concealends

syn region rstInlineInternalTarget matchgroup=rstDelimiter
      \ start=+\(^\|[[:space:]-:/]\)\zs_`\ze[^`[:space:]]+
      \ skip=+\\`+
      \ end=+\S\zs`\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ concealends

syn region rstInterpretedText matchgroup=rstDelimiter contains=rstStandaloneHyperlink
      \ start=+\(^\|[[:space:]-:/]\)\zs\%(:[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*:\)\?`\ze[^`[:space:]]+
      \ skip=+\\`+
      \ end=+\S\zs`_\{0,2}\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ end=+\S\zs`\%(:[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*:\)\?\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ concealends

syn region rstSubstitutionReference matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs|\ze[^|[:space:]]+
      \ skip=+\\|+
      \ end=+\S\zs|_\{0,2}\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+
      \ concealends

for s:ch in [['(', ')'], ['{', '}'], ['<', '>'], ['\[', '\]'], ['"', '"'], ["'", "'"]]
    execute 'syn region rstStrongEmphasis matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs\*\*\ze[^[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs\*\*\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+' .
          \ ' concealends'
    execute 'syn region rstEmphasis matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs\*\ze[^*[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs\*\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+' .
          \ ' concealends'
    execute 'syn region rstInlineLiteral matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs``\ze[^[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs``\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+' .
          \ ' concealends'
    execute 'syn region rstInlineInternalTarget matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs_`\ze[^`[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\`+' .
          \ ' end=+\S\zs`\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+' .
          \ ' concealends'
    execute 'syn region rstInterpretedText matchgroup=rstDelimiter contains=rstStandaloneHyperlink' .
          \ ' start=+'.s:ch[0].'\zs`\ze[^`[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\`+' .
          \ ' end=+\S\zs`_\{0,2}\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+' .
          \ ' concealends'
    execute 'syn region rstSubstitutionReference matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs|\ze[^|[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\|+' .
          \ ' end=+\S\zs|_\{0,2}\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+' .
          \ ' concealends'
endfor

" TODO: Can’t remember why these two can’t be defined like the ones above.
syn match rstFootnoteReference contains=@NoSpell
      \ +\%(\s\|^\)\[\%(\d\+\|#\%([[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*\)\=\|\*\)\]_+

syn match rstCitationReference contains=@NoSpell
      \ +\%(\s\|^\)\[[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*\]_\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)+

syn match rstHyperlinkReference
      \ /\<[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*__\=\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)/

syn match rstStandaloneHyperlink contains=@NoSpell
      \ "\<\%(\%(\%(https\=\|file\|ftp\|gopher\)://\|\%(mailto\|news\):\)[^[:space:]'\"<>]\+\|www[[:alnum:]_-]*\.[[:alnum:]_-]\+\.[^[:space:]'\"<>]\+\)[[:alnum:]/]"

syn region rstCodeBlock contained matchgroup=rstDirective
      \ start="\c\%(sourcecode\|code\%(-block\)\=\)\ze::\_s*\n\z(\s\+\)"
      \ skip=+^$+
      \ end=+^\z1\@!+
      \ contains=rstDirectiveArguments,@NoSpell

syn region rstDirectiveArguments contained
      \ matchgroup=rstDelimiter
      \ start=+::.*+
      \ end=+^\s*$+ contains=@rstInlineMarkup


syn cluster rstDirectives add=rstCodeBlock

if !exists('g:rst_syntax_code_list') || type(g:rst_syntax_code_list) != type({})
    let g:rst_syntax_code_list = {
          \ 'vim': ['vim'],
          \ 'sql': ['sql'],
          \ 'cpp': ['cpp', 'c++'],
          \ 'python': ['python'],
          \ 'json': ['json'],
          \ 'javascript': ['js'],
          \ 'sh': ['sh'],
          \ }
endif

for s:filetype in keys(g:rst_syntax_code_list)
    unlet! b:current_syntax
    " guard against setting 'isk' option which might cause problems (issue #108)
    let prior_isk = &l:iskeyword
    let s:alias_pattern = ''
          \. '\%('
          \. join(g:rst_syntax_code_list[s:filetype], '\|')
          \. '\)'

    exe 'syn include @rstSyntax'.s:filetype.' syntax/'.s:filetype.'.vim'
    exe 'syn region rstCodeBlock'.s:filetype
          \. ' contained matchgroup=rstDirective'
          \. ' start="\c\%(sourcecode\|code\%(-block\)\=\)\ze::\s\+'.s:alias_pattern.'\_s*\n\z(\s\+\)"'
          \. ' skip=#^$#'
          \. ' end=#^\z1\@!#'
          \. ' contains=rstDirectiveArguments,@NoSpell,@rstSyntax'.s:filetype
    exe 'syn cluster rstDirectives add=rstCodeBlock'.s:filetype

    " reset 'isk' setting, if it has been changed
    if &l:iskeyword !=# prior_isk
        let &l:iskeyword = prior_isk
    endif
    unlet! prior_isk
endfor

" Enable top level spell checking
syntax spell toplevel

" TODO: Use better syncing.
syn sync minlines=50 linebreaks=2

hi def link rstTodo                         Todo
hi def link rstComment                      Comment
hi def link rstSection                      Title
hi def link rstSectionDelimiter             Type
hi def link rstDelimiter                    Delimiter
hi def link rstTransition                   rstDelimiter
hi def link rstLiteralBlock                 String
hi def link rstQuotedLiteralBlock           String
hi def link rstDoctestBlock                 PreProc
hi def link rstTableLines                   rstDelimiter
hi def link rstSimpleTable                  rstTableLines
hi def link rstExplicitMarkup               rstDelimiter
hi def link rstDirective                    Keyword
hi def link rstExDirective                  rstDirective
hi def link rstFootnote                     String
hi def link rstCitation                     String
hi def link rstHyperlinkTarget              String
hi def link rstDoubleColon                  rstDelimiter
hi def link rstFieldName                    Constant
hi def link rstLineBlock                    rstDelimiter
hi def link rstListItem                     Constant
hi def link rstInterpretedText              Identifier
hi def link rstInlineLiteral                String
hi def link rstSubstitutionReference        PreProc
hi def link rstSubstitutionDefinition       rstSubstitutionReference
hi def link rstInlineInternalTarget         Identifier
hi def link rstFootnoteReference            Identifier
hi def link rstCitationReference            Identifier
hi def link rstHyperLinkReference           Identifier
hi def link rstStandaloneHyperlink          Underlined
hi def link rstCodeBlock                    String
hi def rstEmphasis term=italic cterm=italic gui=italic
hi def rstStrongEmphasis term=bold cterm=bold gui=bold

let b:current_syntax = "rst"

let &cpo = s:cpo_save
unlet s:cpo_save
