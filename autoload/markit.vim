" Name: autoload/markit.vim
" Author: Maxim Kim <habamax@gmail.com>
" Desc: Mark text with MarkIt highlight group
" Example mappings:
" nnoremap <space>mm :call markit#mark()<CR>
" xnoremap <space>mm <cmd>call markit#mark()<CR><ESC>
" nnoremap <space>mu :call markit#unmark()<CR>
" xnoremap <space>mu <cmd>call markit#unmark()<CR><ESC>
" nnoremap <space>mU :call markit#unmark_all()<CR>
" hi MarkIt guibg=#d7d7af guifg=#5f5f5f ctermbg=187 ctermfg=59


func! markit#mark(type = '')
    " operator boilerplate
    if a:type == ''
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    " let commands = {"line": "'[V']", "char": "`[v`]", "block": "`[\<c-v>`]"}
    " silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')

    hi def link MarkIt IncSearch
    if empty(prop_type_get("markit"))
        call prop_type_add('markit', {'highlight': 'MarkIt'})
    endif

    let start = getpos("'[")
    let end = getpos("']")

    if a:type ==# 'line'
        call prop_add(start[1], start[2], {'end_lnum': end[1], 'end_col': strlen(getline(end[1])) + 1, 'type': 'markit'})
    elseif a:type ==# 'char'
        call prop_add(start[1], start[2], {'end_lnum': end[1], 'end_col': end[2]+1, 'type': 'markit'})
    elseif a:type ==# 'block'
        for lnum in range(start[1], end[1])
            call prop_add(lnum, start[2], {'end_lnum': lnum, 'end_col': end[2]+1, 'type': 'markit'})
        endfor
    endif
endfunc


func! markit#unmark(type = '')
    " operator boilerplate
    if a:type == ''
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif

    let start = getpos("'[")
    let end = getpos("']")

    call prop_remove({'id': 'markit', 'all': v:true}, start[1], end[1])
endfunc


func! markit#unmark_all()
    call prop_remove({'id': 'markit', 'all': v:true})
endfunc
