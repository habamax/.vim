"" Name: autoload/markit.vim
"" Author: Maxim Kim <habamax@gmail.com>
"" Desc: Mark text with MarkIt highlight group
"" Example mappings:
"" nnoremap <space>mm :call markit#mark()<CR>
"" xnoremap <space>mm <cmd>call markit#mark()<CR><ESC>
"" nnoremap <space>mu :call markit#unmark()<CR>
"" xnoremap <space>mu <cmd>call markit#unmark()<CR><ESC>


func! markit#mark()
    hi def link MarkIt IncSearch
    if empty(prop_type_get("markit"))
        call prop_type_add('markit', {'highlight': 'MarkIt'})
    endif

    let start = getpos("v")
    let end = getpos(".")
    if (start[1] == end[1] && start[2] > end[2]) || start[1] > end[1]
        let start = getpos(".")
        let end = getpos("v")
    endif
    if mode() ==# 'V'
        for lnum in range(start[1], end[1])
            call prop_add(lnum, 1, {'length': len(getline(lnum)), 'type': 'markit'})
        endfor
    elseif mode() ==# 'v'
        call prop_add(start[1], start[2], {'end_lnum': end[1], 'end_col': end[2]+1, 'type': 'markit'})
    else
        call prop_add(end[1], 1, {'length': col('$'), 'type': 'markit'})
    endif
endfunc


func! markit#unmark()
    if mode() == 'v'
        let start = getpos("v")
        let end = getpos(".")
        if (start[1] == end[1] && start[2] > end[2]) || start[1] > end[1]
            let start = getpos(".")
            let end = getpos("v")
        endif
        for lnum in range(start[1], end[1])
            call prop_remove({'id': 'markit', 'all': v:true}, lnum)
        endfor
    else
        call prop_remove({'id': 'markit', 'all': v:true}, getpos(".")[1])
    endif
endfunc
