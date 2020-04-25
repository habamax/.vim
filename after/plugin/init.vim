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
    imap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    smap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    imap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    smap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
endif


if exists("g:did_coc_loaded") " {{{1
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
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

