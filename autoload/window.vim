vim9script

const W_THRESHOLD = 160

def Vertical(): string
    # if the overall vim width is too narrow or
    # there are >=2 vertical windows, split horizontally
    if &columns >= W_THRESHOLD && winlayout()[0] != 'row'
        return "vertical"
    endif
    return ""
enddef

# move cursor to the window with largest height
def FindLargestWindow(): number
    var max_height = 0
    var cur_winnr = winnr()
    var max_winnr = winnr()
    for w in range(1, winnr("$"))
        var height = winheight(w)
        if height > max_height
            max_height = height
            max_winnr = w
        elseif height == max_height && w == cur_winnr
            max_winnr = cur_winnr
        endif
    endfor
    return max_winnr
enddef

export def New()
    exe $":{FindLargestWindow()} wincmd w"
    exe $"{Vertical()} new"
enddef
