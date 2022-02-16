vim9script

var orig_guifont: string = &guifont
var orig_lines: number = &lines
var orig_columns: number = &columns

def GetCurrentFont(): list<any>
    var font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')
    return [font[1], str2nr(font[2])]
enddef


export def Change(op: string)
    var [fontname, fontsize] = GetCurrentFont()
    var new_font = orig_guifont
    var new_lines = orig_lines
    var new_columns = orig_columns
    if op == 'inc'
        new_font = fontname .. ':h' .. (fontsize + 1)
        new_lines = float2nr(round(&lines * fontsize / (fontsize + 1))) + 1
        new_columns = float2nr(round(&columns * fontsize / (fontsize + 1))) + 1
    elseif op == 'dec'
        new_font = fontname .. ':h' .. (fontsize - 1)
        new_lines = float2nr(round(&lines * fontsize / (fontsize - 1))) + 1
        new_columns = float2nr(round(&columns * fontsize / (fontsize - 1))) + 1
    endif

    if (fontsize < 8 && op == 'dec') || (fontsize > 30 && op == 'inc')
        return
    endif

    if new_lines > 10 && new_columns > 10
        exe printf('set lines=%s columns=%s', new_lines, new_columns)
        exe printf('set guifont=%s', escape(new_font, ' '))
    endif

    wincmd =
enddef
