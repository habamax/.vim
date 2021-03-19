"" Name: autoload/markit.vim
"" Author: Maxim Kim <habamax@gmail.com>
"" Desc: Mark/highlight text with MarkIt highlight group
"" XXX: Only single highlight is on the line atm.
"" Example mappings:
"" nnoremap <space>mm :call markit#toggle()<CR>
"" xnoremap <space>m <cmd>call markit#toggle()<CR><ESC>


func! markit#highlight()
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

func! markit#clear()
    if mode() == 'v'
        let start = getpos("v")
        let end = getpos(".")
        if (start[1] == end[1] && start[2] > end[2]) || start[1] > end[1]
            let start = getpos(".")
            let end = getpos("v")
        endif
        for lnum in range(start[1], end[1])
            call prop_clear(lnum)
        endfor
    else
        call prop_clear(getpos(".")[1])
    endif
endfunc

func! markit#toggle() abort
    let [_, clnum, ccol, _] = getpos('.')
    let markit = prop_find({'id': 'markit', 'lnum': clnum})

    if empty(markit) || (markit.lnum > clnum)
        call markit#highlight()
    else
        call markit#clear()
    endif
endfunc
