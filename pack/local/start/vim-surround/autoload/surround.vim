vim9script

var pairs = {
    b: '()', '(': '()', ')': '()',
    B: '{}', '{': '{}', '}': '{}',
    s: '[]', '[': '[]', ']': '[]',
    v: '<>', '>': '<>', '<': '<>',
    '1': '!!', '2': '@@', '3': '##', '4': '$$', '5': '%%',
    '6': '^^', '7': '&&', '8': '**', '9': '()', '0': '()',
}

export def Surround(mode: string, s_text: string)
    var region = getregionpos(getpos("'["), getpos("']"), {mode: mode})

    var start = region[0][0]
    var end = region[-1][1]
    var s_left = ''
    var s_right = ''
    if s_text =~ '^<.*>$'
        s_left = s_text
        s_right = '</' .. s_text[1 : -2]->split()[0] .. '>'
    else
        var pair = get(pairs, s_text, '')
        s_left = empty(pair) ? s_text : pair[0]
        s_right = empty(pair) ? s_text : pair[1]
    endif

    if mode == 'char'
        if start[1] == end[1]
            var res_line = SurroundInLine(getline(start[1]), s_left, s_right, start[2], end[2])
            setline(start[1], res_line)
        else
            var res_line = SurroundInLine(getline(start[1]), s_left, s_right, start[2])
            setline(start[1], res_line)
            res_line = SurroundInLine(getline(end[1]), s_right, s_left, end[2] + 1)
            setline(end[1], res_line)
        endif
        exe $"normal! {len(s_left)}l"
    elseif mode == 'line'
        exe $":{start[1]}normal! O{s_left}"
        exe $":{end[1]}normal! jo{s_right}"
        exe $":{start[1] + 1}"
        exe ":normal! _"
    elseif mode == "block"
        region->foreach((_, v) => {
            var res_line = SurroundInLine(getline(v[0][1]), s_left, s_right, start[2], end[2])
            setline(v[0][1], res_line)
        })
    endif
enddef

def SurroundInLine(line: string, s_left: string, s_right: string, start: number, end: number = -1): string
    var res_line = line->slice(0, start - 1)
    res_line ..= s_left
    if end >= 0
        res_line ..= line->slice(start - 1, end)
        res_line ..= s_right
        res_line ..= line->slice(end)
    else
        res_line ..= line->slice(start - 1)
    endif
    return res_line
enddef
