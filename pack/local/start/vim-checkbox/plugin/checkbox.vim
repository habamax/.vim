vim9script

if exists("g:loaded_checkbox")
    finish
endif
g:loaded_checkbox = 1

import autoload 'checkbox.vim'

nnoremap <Plug>(CheckboxToggle) <scriptcmd>checkbox.Toggle(line("v"), line("."))<CR>
xnoremap <Plug>(CheckboxToggle) <scriptcmd>checkbox.Toggle(line("v"), line("."))<CR>

xnoremap <expr> <Plug>(CheckboxToggleOp) checkbox#ToggleOp()
nnoremap <expr> <Plug>(CheckboxToggleOp) checkbox#ToggleOp()
nnoremap <expr> <Plug>(CheckboxToggleLineOp) checkbox#ToggleOp() .. '_'

## example mappings
# xmap <leader>x  <Plug>(CheckboxToggleOp)
# nmap <leader>x  <Plug>(CheckboxToggleOp)
# omap <leader>x  <Plug>(CheckboxToggleOp)
# nmap <leader>xx <Plug>(CheckboxToggleLineOp)
