vim9script

# WIP
# More or less simple surround plugin.
# TODO:
# 1. delete surrounds
# 2. change surrounds?
# 3. bugs
# 4. v:count1 support

import autoload 'surround.vim'

g:surround_with = ''

def SurroundOp(move: string = ''): string
    var char = getcharstr(-1, {cursor: 'keep'})
    if char !~ '\p' && char == "\<Esc>"
        return ''
    endif
    if char == "t"
        var tag  = input("Tag: ")
        if empty(trim(tag))
            return ''
        else
            g:surround_with = '<' .. trim(tag) .. '>'
        endif
    else
        g:surround_with = char
    endif
    &opfunc = (mode) => surround.Surround(mode, g:surround_with)
    return 'g@' .. move
enddef

nnoremap <expr> ys SurroundOp()
nnoremap <expr> yss SurroundOp('_')
xnoremap <expr> s SurroundOp()
nnoremap <expr> <space>s SurroundOp('iw')
