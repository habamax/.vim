"" Settings that depends on plugin existence

if exists("g:loaded_vsnip") " {{{1
    imap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    smap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    imap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    smap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
endif


if exists("g:did_coc_loaded") " {{{1
    " :CocInstall coc-vimlsp
    " :CocInstall coc-python
    " :CocInstall coc-godot

    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ habacoc#check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

    augroup coc_settings | au!
        autocmd CursorHold * silent call CocActionAsync('highlight')
        autocmd FileType gdscript,go,python call habacoc#mappings()
    augroup end
endif


if exists("g:loaded_swap") " {{{1
    omap i, <Plug>(swap-textobject-i)
    xmap i, <Plug>(swap-textobject-i)
    omap a, <Plug>(swap-textobject-a)
    xmap a, <Plug>(swap-textobject-a)
    nmap g< <Plug>(swap-prev)
    nmap g> <Plug>(swap-next)
    nmap g. <Plug>(swap-interactive)
endif
