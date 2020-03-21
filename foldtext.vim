"" My fancy foldtext
" Per buffer setup:
"
" add padding to fold line count (pad to the right)
" let b:foldlines_padding = v:false
"
" char to be used for folding
" let b:foldchar = ''
"
" additional regexp to strip foldtext (example for asciidoctor buffers)
" let b:foldtext_stripregex = '^=\+'

set foldtext=MyFoldText()
func! MyFoldText()
    let l:foldchar = get(b:, 'foldchar', '•')
    let l:strip_regex = get(b:, 'foldtext_stripregex', '')

    let line = getline(v:foldstart)

    " markdown frontmatter -- just take the next line hoping it would be
    " title: Your title
    if line =~ '^----*$'
        let line = getline(v:foldstart+1)
    endif

    let indent = indent(v:foldstart)

    let foldlevel = repeat(l:foldchar, v:foldlevel)
    let foldindent = repeat(' ', max([indent-strdisplaywidth(foldlevel), strdisplaywidth(l:foldchar)]))
    let foldlines = (v:foldend - v:foldstart + 1)

    " always strip away commentstring and {{{
    let strip_comment_regex = '\%(^\s*' 
                \. substitute(&commentstring, '\s*%s\s*', '', '')
                \. '*\s*\)'
    let strip_fold_regex = '\%(\s*{{{\d*\s*\)' 
    let line = substitute(line, strip_comment_regex.'\|'.strip_fold_regex, '', 'g')
    let g:mess=l:strip_regex
    if l:strip_regex != ""
        let line = substitute(line, l:strip_regex, '', 'g')
        let line = substitute(line, '^[[:space:]]*\|[[:space:]]*$', '', 'g')
    endif
    let nontextlen = strdisplaywidth(foldlevel.foldindent.foldlines.' ()')
    let foldtext = strcharpart(line, 0, winwidth(0) - nontextlen)

    if get(b:, 'foldlines_padding', v:false)
        let foldlines_padding = repeat(' ', winwidth(0) - strdisplaywidth(foldtext) - nontextlen + 1)
    else
        let foldlines_padding = ' '
    endif

    return printf("%s%s%s%s(%d)",
                \ foldlevel,
                \ foldindent,
                \ foldtext,
                \ foldlines_padding,
                \ foldlines) 
endfunc

