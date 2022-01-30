vim9script

var s:orig_guifont: string = &guifont
var s:orig_lines: number = &lines
var s:orig_columns: number = &columns

def s:get_current_font(): list<any>
    var font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')
    return [font[1], str2nr(font[2])]
enddef


def guifont_size#change(op: string)
    var [fontname, fontsize] = s:get_current_font()
    var new_font = s:orig_guifont
    var new_lines = s:orig_lines
    var new_columns = s:orig_columns
    if op == 'inc' && fontsize < 40
        new_font = fontname .. ':h' .. (fontsize + 1)
        new_lines = float2nr(round(&lines * fontsize / (fontsize + 1)))
        new_columns = float2nr(round(&columns * fontsize / (fontsize + 1)))
    elseif op == 'dec' && fontsize > 7
        new_font = fontname .. ':h' .. (fontsize - 1)
        new_lines = float2nr(round(&lines * fontsize / (fontsize - 1)))
        new_columns = float2nr(round(&columns * fontsize / (fontsize - 1)))
    endif

    if new_lines > 10 && new_columns > 10
        exe printf('set guifont=%s', escape(new_font, ' '))
        exe printf('set lines=%s columns=%s', new_lines, new_columns)
    endif

    if exists("*win#lens")
        win#lens()
    else
        wincmd =
    endif
enddef
