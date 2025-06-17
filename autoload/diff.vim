vim9script
# Jump to the next or previous diff change.
# Usage:
# import autoload 'diff.vim'
# nnoremap <silent> ]x <scriptcmd>diff.NextChange()<CR>
# nnoremap <silent> [x <scriptcmd>diff.PrevChange()<CR>

export def NextChange()
    if !&diff
        return
    endif
    var line = line('.')
    var col = col('.')
    while diff_hlID(line, col) >= 31 && line <= line('$')
        col += 1
        if col > len(getline(line))
            line += 1
            col = 1
        endif
    endwhile
    while diff_hlID(line, col) < 31 && line <= line('$')
        col += 1
        if col > len(getline(line))
            line += 1
            col = 1
        endif
    endwhile
    if diff_hlID(line, col) >= 31
        cursor(line, col)
    endif
enddef

export def PrevChange()
    var line = line('.')
    var col = col('.')
    while diff_hlID(line, col) >= 31 && line >= 1
        col -= 1
        if col < 1
            line -= 1
            col = len(getline(line))
        endif
    endwhile
    while diff_hlID(line, col) < 31 && line >= 1
        col -= 1
        if col < 1
            line -= 1
            col = len(getline(line))
        endif
    endwhile
    if diff_hlID(line, col) >= 31
        cursor(line, col)
    endif
enddef
