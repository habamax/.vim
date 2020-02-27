" My fancy foldtext
" Buffer setup
" let b:foldlines_padding = v:false
" let b:foldchar = ''
set foldtext=MyFoldText()
func! MyFoldText()
    let l:foldchar = get(b:, 'foldchar', '•')
    " ▸•●□★▢▧▪◆▷▶┄◇□▢○◎

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

    let strip_line = substitute(line, '^//\|=\+\|["#]\|/\*\|\*/\|{{{\d\=\|title:\s*', '', 'g')
    let strip_line = substitute(strip_line, '^[[:space:]]*\|[[:space:]]*$', '', 'g')
    let nontextlen = strdisplaywidth(foldlevel.foldindent.foldlines.' ()')
    let foldtext = strcharpart(strip_line, 0, winwidth(0) - nontextlen)

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

