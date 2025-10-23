vim9script

def Vertical(): string
    if winwidth(winnr()) * 0.3 > winheight(winnr())
        return "vertical"
    else
        return ""
    endif
enddef

# Find the window with largest size
def FindLargestWindow(): number
    var max_size = 0
    var cur_winnr = winnr()
    var max_winnr = winnr()
    for w in range(1, winnr("$"))
        var size = winheight(w) + winwidth(w)
        if size > max_size
            max_size = size
            max_winnr = w
        elseif size == max_size && w == cur_winnr
            max_winnr = cur_winnr
        endif
    endfor
    return max_winnr
enddef

export def New()
    exe $":{FindLargestWindow()} wincmd w"
    exe $"{Vertical()} new"
enddef

export def BotRight(): string
    var res = "botright "
    if &columns * 0.6 < winwidth(winnr()) && &columns > 99
        res = "vertical " .. res
    endif
    return res
enddef
