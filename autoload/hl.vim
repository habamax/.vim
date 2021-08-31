" Name: autoload/hl.vim
" Author: Maxim Kim <habamax@gmail.com>
" Desc: Mark text with HL highlight group
" Example mappings:
" nnoremap <silent><expr> <space>k hl#mark()
" xnoremap <silent><expr> <space>k hl#mark()
" nnoremap <silent><expr> <space>kk hl#mark() .. '_'
" nnoremap <silent><expr> <space>0k hl#unmark()
" xnoremap <silent><expr> <space>0k hl#unmark()
" nnoremap <silent><expr> <space>0kk hl#unmark() .. '_'
" hi HL guibg=#d7d7af guifg=#5f5f5f ctermbg=187 ctermfg=59


func! hl#mark(type = '')
    " operator boilerplate
    if a:type == ''
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    " let commands = {"line": "'[V']", "char": "`[v`]", "block": "`[\<c-v>`]"}
    " silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')

    hi def link HL IncSearch
    if empty(prop_type_get("hl"))
        call prop_type_add('hl', {'highlight': 'HL'})
    endif

    let start = getpos("'[")
    let end = getpos("']")

    if a:type ==# 'line'
        call prop_add(start[1], start[2], {'end_lnum': end[1], 'end_col': strlen(getline(end[1])) + 1, 'type': 'hl'})
    elseif a:type ==# 'char'
        call prop_add(start[1], start[2], {'end_lnum': end[1], 'end_col': end[2]+1, 'type': 'hl'})
    elseif a:type ==# 'block'
        for lnum in range(start[1], end[1])
            call prop_add(lnum, start[2], {'end_lnum': lnum, 'end_col': end[2]+1, 'type': 'hl'})
        endfor
    endif
endfunc


func! hl#unmark(type = '')
    " operator boilerplate
    if a:type == ''
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif

    let start = getpos("'[")
    let end = getpos("']")

    call prop_remove({'id': 'hl', 'all': v:true}, start[1], end[1])
endfunc


func! hl#unmark_all()
    call prop_remove({'id': 'hl', 'all': v:true})
endfunc
