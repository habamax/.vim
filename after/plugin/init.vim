"" Settings that depends on plugin existence


if exists("g:asyncomplete_loaded") " {{{1
    " let g:asyncomplete_log_file = expand("~/vim-asyncomplete.log")
    " let g:asyncomplete_auto_completeopt = 0
    let g:asyncomplete_auto_popup = 0

    imap <expr> <M-n> !pumvisible() ? '<Plug>(asyncomplete_force_refresh)' : "\<C-n>"
    imap <expr> <M-p> !pumvisible() ? '<Plug>(asyncomplete_force_refresh)' : "\<C-p>"

    " fix bad asyncopmlete behaviour of hijacing completeopt
    func! MyAsynCtrlP()
        if !pumvisible()
            setl completeopt=menuone
        endif
        return "\<C-p>"
    endfunc
    func! MyAsynCtrlN()
        if !pumvisible()
            setl completeopt=menuone
        endif
        return "\<C-n>"
    endfunc
    inoremap <expr> <C-p> MyAsynCtrlP()
    inoremap <expr> <C-n> MyAsynCtrlN()

    if exists("g:loaded_endwise")
        imap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR><Plug>DiscretionaryEnd" : "\<CR><Plug>DiscretionaryEnd"
    else
        inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
    endif
endif


if exists("g:loaded_vsnip") " {{{1
    if exists("g:loaded_supertab")
        imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : SuperTab('n')
        smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : SuperTab('n')
        imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : SuperTab('p')
        smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : SuperTab('p')
    else
        imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
        smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
        imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    endif
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

