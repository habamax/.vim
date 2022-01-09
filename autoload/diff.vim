vim9script
# nnoremap <silent> ]x :call diff#next_change()<CR>
# nnoremap <silent> [x :call diff#prev_change()<CR>


def diff#next_change()
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

def diff#prev_change()
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
