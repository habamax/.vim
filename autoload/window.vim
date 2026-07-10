vim9script

export def BotRight(): string
    var res = "botright "
    if &columns * 0.6 < winwidth(winnr()) && &columns > 99
        res = "vertical " .. res
    endif
    return res
enddef
