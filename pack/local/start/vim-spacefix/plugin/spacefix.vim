vim9script

if exists('g:loaded_spacefix')
    finish
endif
g:loaded_spacefix = 1

import autoload 'spacefix.vim'

# Fix spaces:
# * replace non-breaking spaces with spaces
# * replace multiple spaces with a single space (preserving indent)
# * remove spaces between closed braces: ) ) -> ))
# * remove space before closed brace: word ) -> word)
# * remove space after opened brace: ( word -> (word
# * remove space at the end of line


nnoremap <silent> <expr> <Plug>(spacefix) spacefix.Op()
xnoremap <silent> <expr> <Plug>(spacefix) spacefix.Op()
nnoremap <silent> <expr> <Plug>(spacefix-line) spacefix.Op() .. 'l'

if get(g:, 'normspa_mappings', true)
    nmap gs  <Plug>(spacefix)
    xmap gs  <Plug>(spacefix)
    nmap gss <Plug>(spacefix-line)
endif
