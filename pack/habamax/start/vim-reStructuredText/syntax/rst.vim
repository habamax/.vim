" Vim reST syntax file
" Language: reStructuredText syntax file
" Maintainer: Maxim Kim <habamax@gmail.com>
" Description: Based on https://github.com/marshallward/vim-restructuredtext

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match rstTransition /^[=`:.'"~^_*+#-]\{4,}\s*$/


" TODO: rename to rstInline
syn cluster rstCruft contains=rstEmphasis,rstStrongEmphasis,
      \ rstInterpretedText,rstInlineLiteral,rstSubstitutionReference,
      \ rstInlineInternalTarget,rstFootnoteReference,rstHyperlinkReference,
      \ rstStandaloneHyperlink

syn region rstLiteralBlock matchgroup=rstDelimiter
      \ start='\(^\z(\s*\).*\)\@<=::\n\s*\n' skip='^\s*$' end='^\(\z1\s\+\)\@!'
      \ contains=@NoSpell

syn region rstQuotedLiteralBlock matchgroup=rstDelimiter
      \ start="::\_s*\n\ze\z([!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]\)"
      \ end='^\z1\@!' contains=@NoSpell

syn region rstDoctestBlock oneline display matchgroup=rstDelimiter
      \ start='^>>>\s' end='^$'

syn cluster rstTables contains=rstTable,rstSimpleTable
syn region rstTable transparent start='^\n\s*+[-=+]\+' end='^$'
      \ contains=rstTableLines,@rstCruft
syn match rstTableLines contained display '|\|+\%(=\+\|-\+\)\='

syn region rstSimpleTable transparent
      \ start='^\n\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
      \ end='^$'
      \ contains=rstSimpleTableLines,@rstCruft
syn match rstSimpleTableLines contained display
      \ '^\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
syn match rstSimpleTableLines contained display
      \ '^\%(\s*\)\@>\%(\%(-\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(-\+\)\@>\%(\s*\)\@>\)\+\)\@>$'

syn cluster rstDirectives contains=rstFootnote,rstCitation,
      \ rstHyperlinkTarget,rstExDirective

syn match rstExplicitMarkup '^\s*\.\.\_s'
      \ nextgroup=@rstDirectives,rstComment,rstSubstitutionDefinition

syn keyword rstTodo contained FIXME TODO XXX NOTE

" TODO: check if unicode is allowed...
" Simple reference names are single words consisting of alphanumerics plus
" isolated (no two adjacent) internal hyphens, underscores, periods, colons
" and plus signs.
let s:ref_name = '[[:alnum:]]\%([-_.:+]\?[[:alnum:]]\+\)*'

execute 'syn region rstComment contained' .
      \ ' start=/.*/'
      \ ' skip=+^$+' .
      \ ' end=/^\s\@!/ contains=rstTodo'

execute 'syn region rstFootnote contained matchgroup=rstDirective' .
      \ ' start=+\[\%(\d\+\|#\%(' . s:ref_name . '\)\=\|\*\)\]\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,@NoSpell'

execute 'syn region rstCitation contained matchgroup=rstDirective' .
      \ ' start=+\[' . s:ref_name . '\]\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,@NoSpell'

syn region rstHyperlinkTarget contained matchgroup=rstDirective
      \ start='_\%(_\|[^:\\]*\%(\\.[^:\\]*\)*\):\_s' skip=+^$+ end=+^\s\@!+

syn region rstHyperlinkTarget contained matchgroup=rstDirective
      \ start='_`[^`\\]*\%(\\.[^`\\]*\)*`:\_s' skip=+^$+ end=+^\s\@!+

syn region rstHyperlinkTarget matchgroup=rstDirective
      \ start=+^__\_s+ skip=+^$+ end=+^\s\@!+
      \ contains=rstStandaloneHyperlink

execute 'syn region rstExDirective contained transparent matchgroup=rstDirective' .
      \ ' start=+' . s:ref_name . '::\_s+' .
      \ ' skip=+^$+' .
      \ ' end=+^\s\@!+ contains=@rstCruft,@rstTables,rstLiteralBlock'


syn match rstSubstitutionDefinition contained /|.*|\_s\+/ nextgroup=@rstDirectives

" Inline markup recognition rules
" https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#inline-markup
syn region rstStrongEmphasis matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs\*\*\ze[^[:space:]]+
      \ skip=+\\\*+
      \ end=+\S\zs\*\*\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstEmphasis matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs\*\ze[^*[:space:]]+
      \ skip=+\\\*+
      \ end=+\S\zs\*\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstInlineLiteral matchgroup=rstDelimiter
      \ start=+\(^\|[[:space:]-:/]\)\zs``\ze\S+
      \ end=+\S\zs``\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstInlineInternalTarget matchgroup=rstDelimiter
      \ start=+\(^\|[[:space:]-:/]\)\zs_`\ze[^`[:space:]]+
      \ skip=+\\`+
      \ end=+\S\zs`\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstInterpretedText matchgroup=rstDelimiter contains=rstStandaloneHyperlink
      \ start=+\(^\|[[:space:]-:/]\)\zs`\ze[^`[:space:]]+
      \ skip=+\\`+
      \ end=+\S\zs`_\{0,2}\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

syn region rstSubstitutionReference matchgroup=rstDelimiter
      \ start=+\%(^\|[[:space:]-:/]\)\zs|\ze[^|[:space:]]+
      \ skip=+\\|+
      \ end=+\S\zs|_\{0,2}\ze\($\|[[:space:].,:;!?"'/\\>)\]}]\)+

for s:ch in [['(', ')'], ['{', '}'], ['<', '>'], ['\[', '\]'], ['"', '"'], ["'", "'"]]
    execute 'syn region rstStrongEmphasis matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs\*\*\ze[^[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs\*\*\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstEmphasis matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs\*\ze[^*[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs\*\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstInlineLiteral matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs``\ze[^[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\\*+' .
          \ ' end=+\S\zs``\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstInlineInternalTarget matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs_`\ze[^`[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\`+' .
          \ ' end=+\S\zs`\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstInterpretedText matchgroup=rstDelimiter contains=rstStandaloneHyperlink' .
          \ ' start=+'.s:ch[0].'\zs`\ze[^`[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\`+' .
          \ ' end=+\S\zs`_\{0,2}\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
    execute 'syn region rstSubstitutionReference matchgroup=rstDelimiter' .
          \ ' start=+'.s:ch[0].'\zs|\ze[^|[:space:]'.s:ch[1].']+' .
          \ ' skip=+\\|+' .
          \ ' end=+\S\zs|_\{0,2}\ze\($\|[[:space:].,:;!?"'."'".'/\\>)\]}]\)+'
endfor

syn match rstSectionDelimiter contained "\v^([=`:.'"~^_*+#-])\1+\s*$"
syn match rstSection "\v^%(([=`:.'"~^_*+#-])\1+\n)?.{1,2}\n([=`:.'"~^_*+#-])\2+$"
      \ contains=rstSectionDelimiter,@Spell
syn match rstSection "\v^%(([=`:.'"~^_*+#-])\1{2,}\n)?.{3,}\n([=`:.'"~^_*+#-])\2{2,}$"
      \ contains=rstSectionDelimiter,@Spell

" TODO: Can’t remember why these two can’t be defined like the ones above.
execute 'syn match rstFootnoteReference contains=@NoSpell' .
      \ ' +\%(\s\|^\)\[\%(\d\+\|#\%(' . s:ref_name . '\)\=\|\*\)\]_+'

execute 'syn match rstCitationReference contains=@NoSpell' .
      \ ' +\%(\s\|^\)\[' . s:ref_name . '\]_\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)+'

execute 'syn match rstHyperlinkReference' .
      \ ' /\<' . s:ref_name . '__\=\ze\%($\|\s\|[''")\]}>/:.,;!?\\-]\)/'

syn match rstStandaloneHyperlink contains=@NoSpell
      \ "\<\%(\%(\%(https\=\|file\|ftp\|gopher\)://\|\%(mailto\|news\):\)[^[:space:]'\"<>]\+\|www[[:alnum:]_-]*\.[[:alnum:]_-]\+\.[^[:space:]'\"<>]\+\)[[:alnum:]/]"

syn region rstCodeBlock contained matchgroup=rstDirective
      \ start=+\%(sourcecode\|code\%(-block\)\=\)::\s*\(\S*\)\?\s*\n\%(\s*:.*:\s*.*\s*\n\)*\n\ze\z(\s\+\)+
      \ skip=+^$+
      \ end=+^\z1\@!+
      \ contains=@NoSpell
syn cluster rstDirectives add=rstCodeBlock

if !exists('g:rst_syntax_code_list')
    " A mapping from a Vim filetype to a list of alias patterns (pattern
    " branches to be specific, see ':help /pattern'). E.g. given:
    "
    "   let g:rst_syntax_code_list = {
    "       \ 'cpp': ['cpp', 'c++'],
    "       \ }
    "
    " then the respective contents of the following two rST directives:
    "
    "   .. code:: cpp
    "
    "     auto i = 42;
    "
    "   .. code:: C++
    "
    "     auto i = 42;
    "
    " will both be highlighted as C++ code. As shown by the latter block
    " pattern matching will be case-insensitive.
    let g:rst_syntax_code_list = {
        \ 'vim': ['vim'],
        \ 'sql': ['sql'],
        \ 'cpp': ['cpp', 'c++'],
        \ 'python': ['python'],
        \ 'json': ['json'],
        \ 'javascript': ['js'],
        \ 'sh': ['sh'],
        \ }
elseif type(g:rst_syntax_code_list) == type([])
    " backward compatibility with former list format
    let s:old_spec = g:rst_syntax_code_list
    let g:rst_syntax_code_list = {}
    for s:elem in s:old_spec
        let g:rst_syntax_code_list[s:elem] = [s:elem]
    endfor
endif

for s:filetype in keys(g:rst_syntax_code_list)
    unlet! b:current_syntax
    " guard against setting 'isk' option which might cause problems (issue #108)
    let prior_isk = &l:iskeyword
    let s:alias_pattern = ''
          \. '\%('
          \. join(g:rst_syntax_code_list[s:filetype], '\|')
          \. '\)'

    exe 'syn include @rst'.s:filetype.' syntax/'.s:filetype.'.vim'
    exe 'syn region rstDirective'.s:filetype
          \. ' matchgroup=rstDirective fold'
          \. ' start="\c\%(sourcecode\|code\%(-block\)\=\)::\s\+'.s:alias_pattern.'\_s*\n\ze\z(\s\+\)"'
          \. ' skip=#^$#'
          \. ' end=#^\z1\@!#'
          \. ' contains=@NoSpell,@rst'.s:filetype
    exe 'syn cluster rstDirectives add=rstDirective'.s:filetype

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
hi def link rstTransition                   Delimiter
hi def link rstLiteralBlock                 String
hi def link rstQuotedLiteralBlock           String
hi def link rstDoctestBlock                 PreProc
hi def link rstTableLines                   rstDelimiter
hi def link rstSimpleTableLines             rstTableLines
hi def link rstExplicitMarkup               rstDirective
hi def link rstDirective                    Keyword
hi def link rstExDirective                  rstDirective
hi def link rstFootnote                     String
hi def link rstCitation                     String
hi def link rstHyperlinkTarget              String
hi def link rstSubstitutionDefinition       rstDirective
hi def link rstDelimiter                    Delimiter
hi def link rstInterpretedText              Identifier
hi def link rstInlineLiteral                String
hi def link rstSubstitutionReference        PreProc
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

