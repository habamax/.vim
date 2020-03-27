"" Fix text:
"" * replace non-breaking spaces to spaces
"" * replace multiple spaces to a single space (preserving indent)
"" * remove spaces between closed braces: ) ) -> ))
"" * remove space before closed brace: word ) -> word)
"" * remove space after opened brace: ( word -> (word
"" * remove space at the end of line
func! text#fix() range
    let pos=getcurpos()
    " replace non-breaking space to space first
    exe printf('silent %d,%ds/\%%xA0/ /ge', a:firstline, a:lastline)
    " replace multiple spaces to a single space (preserving indent)
    exe printf('silent %d,%ds/\S\+\zs\(\s\|\%%xa0\)\+/ /ge', a:firstline, a:lastline)
    " remove spaces between closed braces: ) ) -> ))
    exe printf('silent %d,%ds/)\s\+)\@=/)/ge', a:firstline, a:lastline)
    " remove spaces between opened braces: ( ( -> ((
    exe printf('silent %d,%ds/(\s\+(\@=/(/ge', a:firstline, a:lastline)
    " remove space before closed brace: word ) -> word)
    exe printf('silent %d,%ds/\s)/)/ge', a:firstline, a:lastline)
    " remove space after opened brace: ( word -> (word
    exe printf('silent %d,%ds/(\s/(/ge', a:firstline, a:lastline)
    " remove space at the end of line
    exe printf('silent %d,%ds/\s*$//ge', a:firstline, a:lastline)
    call setpos('.', pos)
    " nohl
    " echo 'Just one space'
endfunc

"" Underline current line with chars[0]
"" If current line is already underlined with one the chars[1..]
"" Replace it with char[0]
"" call text#underline(['-', '=', '~', '^', '+'])
func! text#underline(chars)
    let nextnr = line('.') + 1
    let underline = repeat(a:chars[0], strchars(getline('.')))
    if index(a:chars, trim(getline(nextnr))[0]) != -1
        call setline(nextnr, underline)
    else
        call append('.', underline)
    endif
endfunc
