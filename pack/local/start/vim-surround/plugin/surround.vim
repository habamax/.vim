vim9script

# WIP
# More or less simple surround plugin.
# Usage:
# 1. ys{char}{motion} to surround with a char or tag, e.g. ys*iw to surround
#    word with * => *word* or ys(iw to surround word with () => (word)
# 2. yss to surround the whole line
# 3. S in visual mode to surround the selection
#
# TODO:
# 1. delete surrounds: dss, ds*, dst, dsB, etc
# 2. change surrounds: css*, cs*_, csbB, etc?
#
# NOTE: visual block doesn't work right if the selection includes tabs.

if exists('g:loaded_surround')
    finish
endif
g:loaded_surround = 1

import autoload 'surround.vim'

def SurroundAdd(move: string = ''): string
    var char = getcharstr(-1, {cursor: 'keep'})
    if char == "\<Esc>" || char == "\<CR>"
        return ''
    endif
    if char == "t"
        var tag  = input("Tag: ")
        if empty(trim(tag))
            return ''
        else
            surround.With('<' .. trim(trim(tag), '<>') .. '>')
        endif
    else
        surround.With(char)
    endif
    surround.VisualDollar(getcursorcharpos()[-1] == v:maxcol)
    &opfunc = (mode) => surround.Add(mode)
    return 'g@' .. move
enddef

def SurroundRemove(): string
    var char = getcharstr(-1, {cursor: 'keep'})
    if char == "\<Esc>" || char == "\<CR>"
        return ''
    endif
    surround.With(char)
    &opfunc = (_) => surround.Remove()
    return 'g@l'
enddef

nnoremap <silent> <expr> <Plug>(surround-add) SurroundAdd()
xnoremap <silent> <expr> <Plug>(surround-add) SurroundAdd()
nnoremap <silent> <expr> <Plug>(surround-line-add) SurroundAdd('_')
nnoremap <silent> <expr> <Plug>(surround-word-add) SurroundAdd('iw')
nnoremap <silent> <expr> <Plug>(surround-remove) SurroundRemove()

if get(g:, 'surround_mappings', true)
    nmap ys <Plug>(surround-add)
    nmap yss <Plug>(surround-line-add)
    xmap S <Plug>(surround-add)
    nmap ds <Plug>(surround-remove)
endif
