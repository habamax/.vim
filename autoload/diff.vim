vim9script
# Jump to the next or previous diff change.
# Usage:
# import autoload 'diff.vim'
# nnoremap <silent> ]x <scriptcmd>diff.NextChange()<CR>
# nnoremap <silent> [x <scriptcmd>diff.PrevChange()<CR>

def IsDiffChange(line: number, col: number): bool
    return [
        hlID("DiffChange"),
        hlID("DiffText"),
        hlID("DiffTextAdd")
    ]->index(diff_hlID(line, col)) != -1
enddef

def IsDiffText(line: number, col: number): bool
    return [
        hlID("DiffText"),
        hlID("DiffTextAdd")
    ]->index(diff_hlID(line, col)) != -1
enddef

export def NextChange()
    if !&diff
        return
    endif

    var line = line('.')
    var col = col('.')
    while IsDiffText(line, col) && line <= line('$')
        col += 1
        if col > len(getline(line))
            line += 1
            col = 1
        endif
    endwhile

    while !IsDiffText(line, col) && line <= line('$')
        col += 1
        if col > len(getline(line))
            line += 1
            col = 1
            while !IsDiffChange(line, col) && line <= line('$')
                line += 1
            endwhile
        endif
    endwhile

    if IsDiffText(line, col)
        cursor(line, col)
    endif
enddef

export def PrevChange()
    if !&diff
        return
    endif

    var line = line('.')
    var col = col('.')
    while IsDiffText(line, col) && line >= 1
        col -= 1
        if col < 1
            line -= 1
            col = len(getline(line))
        endif
    endwhile

    while !IsDiffText(line, col) && line >= 1
        col -= 1
        if col < 1
            line -= 1
            col = len(getline(line))
            while !IsDiffChange(line, col) && line >= 1
                line -= 1
                col = len(getline(line))
            endwhile
        endif
    endwhile

    if IsDiffText(line, col)
        cursor(line, col)
    endif
enddef
