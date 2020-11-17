"" Name: autoload/text.vim
"" Author: Maxim Kim <habamax@gmail.com>
"" Desc: Text manipulation functions.

"" Fix text:
"" * replace non-breaking spaces to spaces
"" * replace multiple spaces to a single space (preserving indent)
"" * remove spaces between closed braces: ) ) -> ))
"" * remove space before closed brace: word ) -> word)
"" * remove space after opened brace: ( word -> (word
"" * remove space at the end of line
"" Usage:
"" command! -range TextFixSpaces <line1>,<line2>call text#fix_spaces()
"" nnoremap <leader><leader><leader> :TextFixSpaces<CR>
"" xnoremap <leader><leader><leader> :TextFixSpaces<CR>
func! text#fix_spaces() range
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


"" Dates (text object and stuff)
let s:mons_en = ['Jan', 'Feb', 'Mar', 'Apr',
               \ 'May', 'Jun', 'Jul', 'Aug',
               \ 'Sep', 'Oct', 'Nov', 'Dec']
let s:months_en = ['January', 'February', 'March', 'April',
                 \ 'May', 'June', 'July', 'August',
                 \ 'September', 'October', 'November', 'December']
let s:months_ru = ['января', 'февраля', 'марта', 'апреля',
                 \ 'мая', 'июня', 'июля', 'августа',
                 \ 'сентября', 'октября', 'ноября', 'декабря']

let s:months = extend(s:months_en, s:months_ru)
let s:months = extend(s:months, s:mons_en)
let g:months = copy(s:months)

"" * ISO-8601 2020-03-21
"" * RU 21 марта 2020
"" * EN 10 December 2012
"" * EN December 10, 2012
"" * EN 10 Dec 2012
"" * EN Dec 10, 2012
"" Usage:
"" xnoremap <silent> id :<C-u>call text#date_textobj(1)<CR>
"" onoremap id :<C-u>normal vid<CR>
"" xnoremap <silent> ad :<C-u>call text#date_textobj(0)<CR>
"" onoremap ad :<C-u>normal vad<CR>
func! text#date_textobj(inner)
    let save_cursor = getcurpos()
    let cword = expand("<cword>")
    if  cword =~ '\d\{4}'
        let rx = '^\|'
        let rx = '\%(\D\d\{1,2}\s\+\%(' . join(s:months, '\|') . '\)\)'
        let rx .= '\|'
        let rx .= '\%(\s*\%(' . join(s:months, '\|') . '\)\s\+\d\{1,2},\)'
        if !search(rx, 'bcW', line('.'))
            call search('\s*\D', 'bcW', line('.'))
        endif
    elseif cword =~ join(s:months, '\|')
        call search('^\|\D\ze\d\{1,2}\s\+', 'bceW')
    elseif cword =~ '\d\{1,2}'
        if !search('^\|\S\ze\%(' . join(s:months, '\|') . '\)\s\+\d\{1,2}', 'bceW')
            call search('^\|[^0-9\-]', 'becW')
        endif
    endif

    let rxdate = '\%(\d\{4}-\d\{2}-\d\{2}\)'
    let rxdate .= '\|'
    let rxdate .= '\%(\d\{1,2}\s\+\%(' . join(s:months, '\|') . '\)\s\+\d\{4}\)'
    let rxdate .= '\|'
    let rxdate .= '\%(\%(' . join(s:months, '\|') . '\)\s\+\d\{1,2},\s\+\d\{4}\)'
    if !a:inner
        let rxdate = '\s*\%('.rxdate.'\)\s*'
    endif

    if search(rxdate, 'cW')
        normal v
        call search(rxdate, 'ecW')
        return
    endif
    call setpos('.', save_cursor)
endfunc


func! text#date_ru()
    let [year, month, day] = split(strftime("%Y-%m-%d"), '-')
    return printf("%d %s %s", day, s:months_ru[month-1], year)
endfunc


"" Indent text object
"" Useful for python-like indentation based programming lanugages
"" Usage:
"" onoremap <silent>ii :<C-u>call text#indent_textobj(v:true)<CR>
"" onoremap <silent>ai :<C-u>call text#indent_textobj(v:false)<CR>
"" xnoremap <silent>ii :<C-u>call text#indent_textobj(v:true)<CR>
"" xnoremap <silent>ai :<C-u>call text#indent_textobj(v:false)<CR>
func! text#indent_textobj(inner)
    if getline('.') =~ '^\s*$'
        let ln_start = s:detect_nearest_line()
        let ln_end = ln_start
    else
        let ln_start = line('.')
        let ln_end = ln_start
    endif

    let indent = indent(ln_start)
    if indent > 0
        while indent(ln_start) >= indent && ln_start > 0
            let ln_start = prevnonblank(ln_start-1)
        endwhile

        while indent(ln_end) >= indent && ln_end <= line('$')
            let ln_end = s:nextnonblank(ln_end+1)
        endwhile
    else
        while indent(ln_start) == 0 && ln_start > 0 && getline(ln_start) !~ '^\s*$'
            let ln_start -= 1
        endwhile
        while indent(ln_start) > 0 && ln_start > 0
            let ln_start = prevnonblank(ln_start-1)
        endwhile
        while indent(ln_start) == 0 && ln_start > 0 && getline(ln_start) !~ '^\s*$'
            let ln_start -= 1
        endwhile

        while indent(ln_end) == 0 && ln_end <= line('$') && getline(ln_end) !~ '^\s*$'
            let ln_end += 1
        endwhile
        while indent(ln_end) > 0 && ln_end <= line('$')
            let ln_end = s:nextnonblank(ln_end+1)
        endwhile
    endif

    if a:inner || indent == 0
        let ln_start = s:nextnonblank(ln_start+1)
    endif

    if a:inner
        let ln_end = prevnonblank(ln_end-1)
    else
        let ln_end = ln_end-1
    endif

    if ln_end < ln_start
        let ln_end = ln_start
    endif

    exe ln_end
    normal! V
    exe ln_start
endfunc


func! s:nextnonblank(lnum) abort
    let res = nextnonblank(a:lnum)
    if res == 0
        let res = line('$')+1
    endif
    return res
endfunc


func! s:detect_nearest_line() abort
    let lnum = line('.')
    let nline = s:nextnonblank(lnum)
    let pline = prevnonblank(lnum)
    if abs(nline - lnum) > abs(pline - lnum) || getline(nline) =~ '^\s*$'
        return pline
    else
        return nline
    endif
endfunc


"" 24 simple text objects
"" ----------------------
"" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
"" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
"" Usage:
""for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
""    execute 'xnoremap <silent> i' .. char .. ' :<C-u>call text#simple_textobj("'..char..'", 1)<CR>'
""    execute 'xnoremap <silent> a' .. char .. ' :<C-u>call text#simple_textobj("'..char..'", 0)<CR>'
""    execute 'onoremap <silent> i' .. char .. ' :normal vi' . char . '<CR>'
""    execute 'onoremap <silent> a' .. char .. ' :normal va' . char . '<CR>'
""endfor
func! text#simple_textobj(char, inner) abort
    let lnum = line('.')
    let char = escape(a:char, '.*')
    if search(char..'[^'..a:char..']\{-}'..char, 'cbW', lnum)
        if a:inner
            normal! l
        endif
        normal! v
        call search(char, 'W', lnum)
        if a:inner
            normal! h
        endif
    endif
endfunc
