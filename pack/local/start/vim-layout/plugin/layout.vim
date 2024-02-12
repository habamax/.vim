vim9script

if exists('g:loaded_layout')
    finish
endif
g:loaded_layout = 1

import autoload 'layout.vim'

augroup layout | au!
    au BufEnter * call layout#Save('BufEnter')
    au WinNew * call layout#Save('WinNew')
    au QuitPre * call layout#Save('QuitPre')
augroup END

command! LayoutNext layout.Restore(1)
command! LayoutPrev layout.Restore(-1)
