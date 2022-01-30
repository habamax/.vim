" checkbox.vim -- [X] Checkboxes
" Author: Maxim Kim <habamax@gmail.com>

if exists("g:loaded_checkbox") || &cp || v:version < 700
    finish
endif
let g:loaded_checkbox = 1

command! -range CheckboxToggle :call checkbox#toggle(<line1>,<line2>)
nnoremap <Plug>(CheckboxToggle) :CheckboxToggle<CR>
xnoremap <Plug>(CheckboxToggle) :CheckboxToggle<CR>

xnoremap <expr> <Plug>(CheckboxToggleOp) checkbox#toggle_op()
nnoremap <expr> <Plug>(CheckboxToggleOp) checkbox#toggle_op()
nnoremap <expr> <Plug>(CheckboxToggleLineOp) checkbox#toggle_op() . '_'

"" example mappings
" xmap <leader>x  <Plug>(CheckboxToggleOp)
" nmap <leader>x  <Plug>(CheckboxToggleOp)
" omap <leader>x  <Plug>(CheckboxToggleOp)
" nmap <leader>xx <Plug>(CheckboxToggleLineOp)
