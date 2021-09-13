func! s:comment(...)
    if a:0 == 0
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    if empty(&cms) | return | endif
    let cms = substitute(substitute(&cms, '\S\zs%s\s*', ' %s', ''), '%s\ze\S', '%s ', '')
    let [lnum1, lnum2] = [line("'["), line("']")]
    let cms_l = split(escape(cms, '*.'), '%s')
    if len(cms_l) == 0 | return | endif
    if len(cms_l) == 1 | call add(cms_l, '') | endif
    let comment = 0
    let indent_min = indent(lnum1)
    let indent_start = matchstr(getline(lnum1), '^\s*')
    for lnum in range(lnum1, lnum2)
        if getline(lnum) =~ '^\s*$' | continue | endif
        if indent_min > indent(lnum)
            let indent_min = indent(lnum)
            let indent_start = matchstr(getline(lnum), '^\s*')
        endif
        if getline(lnum) !~ '^\s*' . cms_l[0] . '.*' . cms_l[1] . '$'
            let comment = 1
        endif
    endfor
    let lines = []
    for lnum in range(lnum1, lnum2)
        if getline(lnum) =~ '^\s*$'
            let line = getline(lnum)
        elseif comment
            if exists("g:comment_first_col") || exists("b:comment_first_col")
                let line = printf(cms, getline(lnum))
            else
                let line = printf(indent_start . cms, strpart(getline(lnum), strlen(indent_start)))
            endif
        else
            let line = substitute(getline(lnum), '^\s*\zs'.cms_l[0].'\|'.cms_l[1].'$', '', 'g')
        endif
        call add(lines, line)
    endfor
    noautocmd keepjumps call setline(lnum1, lines)
endfunc
nnoremap <silent> <expr> gc <SID>comment()
xnoremap <silent> <expr> gc <SID>comment()
nnoremap <silent> <expr> gcc <SID>comment() . '_'
