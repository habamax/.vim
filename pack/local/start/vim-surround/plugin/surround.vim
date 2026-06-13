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
# 1. fix unicode change surround: ysqe and csqQ -> end surround is wrong
# 1. fix change surround cursor (position)
#
# NOTE: visual block doesn't work right if the selection includes tabs.

if exists('g:loaded_surround')
    finish
endif
g:loaded_surround = 1

import autoload 'surround.vim'

nnoremap <silent> <expr> <Plug>(surround-add) surround.Add()
xnoremap <silent> <expr> <Plug>(surround-add) surround.Add()
nnoremap <silent> <expr> <Plug>(surround-line-add) surround.Add('_')
nnoremap <silent> <expr> <Plug>(surround-word-add) surround.Add('iw')
nnoremap <silent> <expr> <Plug>(surround-remove) surround.Remove()
nnoremap <silent> <expr> <Plug>(surround-change) surround.Change()

if get(g:, 'surround_mappings', true)
    nmap ys <Plug>(surround-add)
    nmap yss <Plug>(surround-line-add)
    xmap S <Plug>(surround-add)
    nmap ds <Plug>(surround-remove)
    nmap cs <Plug>(surround-change)
endif
