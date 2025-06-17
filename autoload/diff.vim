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
    while synIDattr(diff_hlID(line, col), "name") =~ 'DiffText.*' && line <= line('$')
        col += 1
        if col > len(getline(line))
            line += 1
            col = 1
        endif
    endwhile
    while synIDattr(diff_hlID(line, col), "name") !~ 'DiffText.*' && line <= line('$')
        col += 1
        if col > len(getline(line))
            line += 1
            col = 1
        endif
    endwhile
    if synIDattr(diff_hlID(line, col), "name") =~ 'DiffText.*'
        cursor(line, col)
    endif
enddef

export def PrevChange()
    var line = line('.')
    var col = col('.')
    while synIDattr(diff_hlID(line, col), "name") =~ 'DiffText.*' && line >= 1
        col -= 1
        if col < 1
            line -= 1
            col = len(getline(line))
        endif
    endwhile
    while synIDattr(diff_hlID(line, col), "name") !~ 'DiffText.*' && line >= 1
        col -= 1
        if col < 1
            line -= 1
            col = len(getline(line))
        endif
    endwhile
    if synIDattr(diff_hlID(line, col), "name") =~ 'DiffText.*'
        cursor(line, col)
    endif
enddef
