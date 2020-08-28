"" Name: autoload/text.vim
"" Author: Maxim Kim <habamax@gmail.com>
"" Desc: Text manipulation functions.


"" Fix text: {{{1
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


"" Underline current line with chars[0] {{{1
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


"" ISO-8601 date text object {{{1
"" 2020-03-21
"" Usage:
"" xnoremap <silent> id :<C-u>call text#obj_date(1)<CR>
"" onoremap id :<C-u>normal vid<CR>
"" xnoremap <silent> ad :<C-u>call text#obj_date(0)<CR>
"" onoremap ad :<C-u>normal vad<CR>
func! text#obj_date(inner)
    let months = ['января', 'февраля', 'марта', 'апреля',
                \ 'мая', 'июня', 'июля', 'августа',
                \ 'сентября', 'октября', 'ноября', 'декабря']

    let save_cursor = getcurpos()
    let cword = expand("<cword>")
    if  cword =~ '\d\{4}'
        call search('^\|\D\ze\d\{1,2}\s\+\%(' . join(months, '\|') . '\)', 'bceW')
    elseif cword =~ join(months, '\|')
        call search('^\|\D\ze\d\{1,2}\s\+', 'bceW')
    elseif cword =~ '\d\{1,2}'
        call search('^\|[^0-9\-]', 'becW')
        " call search('^\|\D', 'bceW')
    endif

    let rxdate = '\%(\d\{4}-\d\{2}-\d\{2}\)'
    let rxdate .= '\|'
    let rxdate .= '\%(\d\{1,2}\s\+\%(' . join(months, '\|') . '\)\s\+\d\{4}\)'
    if !a:inner
        let rxdate = '\s*'.rxdate.'\s*'
    endif

    if search(rxdate, 'cW')
        normal v
        call search(rxdate, 'ecW')
        return
    endif
    call setpos('.', save_cursor)
endfunc


"" Indent text object {{{1
"" Useful for python-like indentation based programming lanugages
"" Usage:
"" onoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
"" onoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
"" xnoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
"" xnoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
func! text#obj_indent(inner)
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
