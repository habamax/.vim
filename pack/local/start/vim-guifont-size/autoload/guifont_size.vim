vim9script

var orig_guifont: string = &guifont

if empty(orig_guifont)
    if has("win32")
        orig_guifont = 'Consolas:h12'
    else
        orig_guifont = 'Monospace 12'
    endif
    &guifont = orig_guifont
endif

def GetFontParams(font: string): list<any>
    var params: list<string>
    if has("win32")
        params = matchlist(font, '\v(.{-}):h(\d+(\.\d+)?)')
    else
        params = matchlist(font, '\v(.{-}) (\d+(\.\d+)?)$')
    endif
    return [params[1], str2nr(params[2])]
enddef


export def Change(op: string)
    var cur_fonts = &guifont->split(",")
    var new_fonts = []

    for font in cur_fonts
        var [fontname, fontsize] = GetFontParams(font)

        if (fontsize < 8 && op == 'dec') || (fontsize > 64 && op == 'inc')
            return
        endif

        if op == 'inc'
            new_fonts->add(fontname .. (has("win32") ? ':h' : ' ') .. (fontsize + 1))
        elseif op == 'dec'
            new_fonts->add(fontname .. (has("win32") ? ':h' : ' ') .. (fontsize - 1))
        endif
    endfor

    if op == 'restore'
        exe printf('&guifont = "%s"', orig_guifont)
    else
        exe printf('set guifont=%s', escape(new_fonts->join(','), ' '))
    endif

    wincmd =
enddef
