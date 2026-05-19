vim9script

# WIP
# More or less simple surround plugin.
# Usage:
# 1. ys{char}{motion} to surround with a char or tag, e.g. ys*iw to surround
#    word with * => *word* or ys(iw to surround word with () => (word)
# 2. yss to surround the whole line
# 3. s in visual mode to surround the selection
# 4. <space>s to surround the word under cursor
#
# TODO:
# 1. delete surrounds
# 2. change surrounds?
# 3. bugs

if exists('g:loaded_surround')
    finish
endif
g:loaded_surround = 1

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
