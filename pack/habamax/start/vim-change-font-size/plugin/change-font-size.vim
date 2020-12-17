"" change-font-size.vim - Change GUI vim font size
"" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("g:loaded_change_font_size") || !has("gui_running")
    finish
endif

let g:loaded_change_font_size = 1


fun! s:getCurrentFont()
    let font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')

    if !exists("s:orig_guifont")
        let s:orig_guifont = &guifont
        let s:orig_lines = &lines
        let s:orig_columns = &columns
    endif

    return [font[1], font[2]]
endfu


fun! s:changeFontSize(op)
    let [fontname,fontsize] = s:getCurrentFont()

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
endfu

" looks like this is windows only
nnoremap <silent> <A--> :call <sid>changeFontSize('dec')<CR>
nnoremap <silent> <A-=> :call <sid>changeFontSize('inc')<CR>
nnoremap <silent> <A-0> :call <sid>changeFontSize('restore')<CR>

