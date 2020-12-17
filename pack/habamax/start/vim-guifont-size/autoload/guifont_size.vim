
func! s:get_current_font()
    let font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')

    if !exists("s:orig_guifont")
        let s:orig_guifont = &guifont
        let s:orig_lines = &lines
        let s:orig_columns = &columns
    endif

    return [font[1], font[2]]
endfunc


func! guifont_size#change(op)
    let [fontname,fontsize] = s:get_current_font()

    if a:op == 'inc' && fontsize < 40
        let new_font = fontname.':h'.(fontsize + 1)
        let new_lines = float2nr(round(&lines * fontsize/str2float(fontsize + 1)))
        let new_columns = float2nr(round(&columns * fontsize/str2float(fontsize + 1)))
    elseif a:op == 'dec' && fontsize > 7
        let new_font = fontname.':h'.(fontsize - 1)
        let new_lines = float2nr(round(&lines * fontsize/str2float(fontsize - 1)))
        let new_columns = float2nr(round(&columns * fontsize/str2float(fontsize - 1)))
    elseif a:op == 'restore'
        let new_font = s:orig_guifont
        let new_lines = s:orig_lines
        let new_columns = s:orig_columns
    else
        return
    endif

    if new_lines > 10 && new_columns > 10
        exe printf('set guifont=%s', escape(new_font, ' '))
        exe printf('set lines=%s columns=%s', new_lines, new_columns)
    endif

    if exists("*win#lens")
        call win#lens()
    else
        wincmd =
    endif
endfunc
