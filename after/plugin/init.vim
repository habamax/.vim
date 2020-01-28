"" Settings that depends on plugin existence

if exists("g:yoinkInitialized") " {{{1
	nmap <c-n> <plug>(YoinkPostPasteSwapBack)
	nmap <c-p> <plug>(YoinkPostPasteSwapForward)

	nmap p <plug>(YoinkPaste_p)
	nmap P <plug>(YoinkPaste_P)
endif

if exists("g:loaded_skipit") " {{{1
	imap <A-.> <Plug>(SkipItForward)
	imap <A-,> <Plug>(SkipItBack)
endif

if exists("g:asyncomplete_loaded") " {{{1
	" let g:asyncomplete_auto_completeopt = 0
	" let g:asyncomplete_auto_popup = 0
	imap <C-Space> <Plug>(asyncomplete_force_refresh)
	if exists("g:loaded_endwise")
		imap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR><Plug>DiscretionaryEnd" : "\<CR><Plug>DiscretionaryEnd"
	else
		inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
	endif

	" buggy. See https://github.com/prabirshrestha/asyncomplete-file.vim/issues/4
	" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
	" 			\ 'name': 'file',
	" 			\ 'whitelist': ['*'],
	" 			\ 'priority': 10,
	" 			\ 'completor': function('asyncomplete#sources#file#completor')
	" 			\ }))
endif


if exists("g:loaded_vsnip") " {{{1
	imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
	smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
	imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
	smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
endif

if exists("g:loaded_swap") " {{{1
	" there is targets.vim, let's check it
	" omap i, <Plug>(swap-textobject-i)
	" xmap i, <Plug>(swap-textobject-i)
	" omap a, <Plug>(swap-textobject-a)
	" xmap a, <Plug>(swap-textobject-a)
	nmap g< <Plug>(swap-prev)
	nmap g> <Plug>(swap-next)
	nmap g. <Plug>(swap-interactive)
endif

