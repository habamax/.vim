"" Settings that depends on plugin existence

if exists("g:loaded_vsnip") " {{{1
    imap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    smap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    imap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    smap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
endif


if exists("g:did_coc_loaded") && get(g:, "coc_start_at_startup", v:true) " {{{1
    " :CocInstall coc-vimlsp
    " :CocInstall coc-python
    " :CocInstall coc-godot

    call habacoc#setup()
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

if exists("g:loaded_winlayout")
    nmap <F3> <Plug>(WinlayoutBackward)
    nmap <F4> <Plug>(WinlayoutForward)
endif
