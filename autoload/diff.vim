vim9script
# nnoremap <silent> ]x :call diff#NextChange()<CR>
# nnoremap <silent> [x :call diff#PrevChange()<CR>


export def NextChange()
    if !&diff
        return
    endif
    var line = line('.')
    if diff_hlID(line, col('.')) == 28
        line += 1
    endif
    while line <= line('$')
        var change_pos = filter(range(1, len(getline(line))), 'diff_hlID(line, v:val) == 28')
        if !empty(change_pos)
            cursor(line, change_pos[0])
            return
        endif
        line += 1
    endwhile
enddef

export def PrevChange()
    if !&diff
        return
    endif
    var line = line('.')
    if diff_hlID(line, col('.')) == 28
        line -= 1
    endif
    while line > 1
        var change_pos = filter(range(1, len(getline(line))), 'diff_hlID(line, v:val) == 28')
        if !empty(change_pos)
            cursor(line, change_pos[0])
            return
        endif
        line -= 1
    endwhile
enddef
