vim9script

# Author:  Maxim Kim https://github.com/habamax
# Website: https://www.github.com/vim/colorschemes
# Description:
# Highlight xterm256 colors in :h xterm256-palette

def FG(bgs: string): dict<string>
    var bg = bgs->str2nr()
    if   (bg >= 8 && bg <= 15)
      || (bg >= 40 && bg <= 51)
      || (bg >= 76 && bg <= 87)
      || (bg >= 112 && bg <= 123)
      || (bg >= 148 && bg <= 159)
      || (bg >= 184 && bg <= 195)
      || (bg >= 220 && bg <= 231)
      || (bg >= 250 && bg <= 255)
        return {gui: "black", term: "16"}
    else
        return {gui: "white", term: "255"}
    endif
enddef

def HL(ln_start: number, ln_end: number)
    if ln_start == 0
        echom "Can't find xterm colors!"
        return
    endif
    for lnum in range(ln_start, ln_end)
        var line = getline(lnum)
        if empty(line) | continue | endif
        var colors = split(line, '\s\{6,}')->map((_, v) => split(trim(v), '\s\+'))
        for color in colors
            if empty(color) | continue | endif
            exe printf('syn match Hi%s /\%%%sl%s/', color[0], lnum, $'\s\{{10}}\ze\s{color[0]}\s\+{color[1]}')
            exe printf("hi Hi%s guibg=%s ctermbg=%s guifg=%s ctermfg=%s", color[0], color[1], color[0],
                \ FG(color[0]).gui, FG(color[0]).term)
        endfor
    endfor
enddef

HL(search("0 #000000", "n"), search("255 #eeeeee", "n"))
