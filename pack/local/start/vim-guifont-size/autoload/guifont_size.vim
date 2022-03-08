vim9script

var orig_guifont: string = &guifont
var orig_lines: number = &lines
var orig_columns: number = &columns

def GetCurrentFont(): list<any>
    var font: list<string>
    if has("win32")
        font = matchlist(&guifont, '\(.\{-}\):h\(\d\+\)')
    else
        font = matchlist(&guifont, '\(.\{-}\)\ \(\d\+\)$')
    endif
    return [font[1], str2nr(font[2])]
enddef


export def Change(op: string)
    var [fontname, fontsize] = GetCurrentFont()

    if (fontsize < 8 && op == 'dec') || (fontsize > 30 && op == 'inc')
        return
    endif

    var new_font = orig_guifont

    if op == 'inc'
        new_font = fontname .. (has("win32") ? 'h:' : '  ') .. (fontsize + 1)
    elseif op == 'dec'
        new_font = fontname .. (has("win32") ? 'h:' : '  ') .. (fontsize - 1)
    endif

    if has("win32")
        var lines = orig_lines
        var columns = orig_columns
        if op == 'inc'
            lines = float2nr(round(&lines * fontsize / (fontsize + 1))) + 1
            columns = float2nr(round(&columns * fontsize / (fontsize + 1))) + 1
        elseif op == 'dec'
            lines = float2nr(round(&lines * fontsize / (fontsize - 1))) + 1
            columns = float2nr(round(&columns * fontsize / (fontsize - 1))) + 1
        endif
        if lines > 10 && columns > 10
            exe printf('set lines=%s columns=%s', lines, columns)
        endif
    endif

    exe printf('set guifont=%s', escape(new_font, ' '))

    wincmd =
enddef
