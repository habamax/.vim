" nnoremap <silent> ]x :call diff#next_change()<CR>
" nnoremap <silent> [x :call diff#prev_change()<CR>


func! diff#next_change() abort
    if !&diff
        return
    endif
    let line = line('.')
    if diff_hlID(line, col('.')) == 28
        let line += 1
    endif
    while line <= line('$')
        let change_pos = filter(range(1, len(getline(line))), 'diff_hlID(line, v:val) == 28')
        if !empty(change_pos)
            call cursor(line, change_pos[0])
            return
        endif
        let line += 1
    endwhile
endfunc

func! diff#prev_change() abort
    if !&diff
        return
    endif
    let line = line('.')
    if diff_hlID(line, col('.')) == 28
        let line -= 1
    endif
    while line > 1
        let change_pos = filter(range(1, len(getline(line))), 'diff_hlID(line, v:val) == 28')
        if !empty(change_pos)
            call cursor(line, change_pos[0])
            return
        endif
        let line -= 1
    endwhile
endfunc
