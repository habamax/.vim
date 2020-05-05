" listopad.vim -- Manipulate lists
" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("g:loaded_listopad") || &cp || v:version < 700
    finish
endif
let g:loaded_listopad = 1

command! -range ListopadToggleCheckbox :call listopad#toggle_checkboxes(<line1>,<line2>)
nnoremap <Plug>(ListopadToggleCheckbox) :ListopadToggleCheckbox<CR>
vnoremap <Plug>(ListopadToggleCheckbox) :ListopadToggleCheckbox<CR>
xnoremap <Plug>(ListopadToggleCheckbox) :ListopadToggleCheckbox<CR>

xnoremap <expr> <Plug>(ListopadToggleCheckboxOp) listopad#op_toggle_checkboxes()
nnoremap <expr> <Plug>(ListopadToggleCheckboxOp) listopad#op_toggle_checkboxes()
nnoremap <expr> <Plug>(ListopadToggleCheckboxLineOp) listopad#op_toggle_checkboxes() . '_'


if get(g:, "listopad_default_mappings", v:false)
    if !hasmapto('<Plug>(ListopadToggleCheckboxOp)') && maparg('<leader>x','n') ==# ''
        xmap <leader>x  <Plug>(ListopadToggleCheckboxOp)
        nmap <leader>x  <Plug>(ListopadToggleCheckboxOp)
        omap <leader>x  <Plug>(ListopadToggleCheckboxOp)
        nmap <leader>xx <Plug>(ListopadToggleCheckboxLineOp)
    endif
endif
