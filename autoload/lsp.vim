let s:lsp_ft_maps = get(g:, 'lsp_ft_maps', 'gdscript,go,python,nim')

" XXX: rewrite it to have YCM with vim-lsp fallback
" CoC should be removed

func! lsp#setup()
    " Try to load YouCompleteMe first
    let g:ycm_auto_hover = ''
    let g:ycm_language_server =
                \ [
                \   {
                \     'name': 'gdscript',
                \     'project_root_files': ['project.godot'],
                \     'port': 6008,
                \     'filetypes': [ 'gdscript' ]
                \   },
                \   {
                \     'name': 'nim',
                \     'cmdline': ['nimlsp'],
                \     'filetypes': [ 'nim' ]
                \   }
                \ ]
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1

    silent! packadd YouCompleteMe

    if exists("g:loaded_youcompleteme")
        " Should be after package load, otherwise it will add ycm_nofiletype
        " here there will be no autocomplete in buffers with no filetype
        let g:ycm_filetype_blacklist = {'selectprompt': 1}

        augroup ycm_settings | au!
            exe printf('au FileType %s call lsp#ycm_mappings()', s:lsp_ft_maps)
        augroup end
    else
        silent! packadd mucomplete
        if exists("g:loaded_mucomplete")
            MUcompleteAutoOn
        endif
    endif

endfunc


func! lsp#ycm_mappings() abort
    nmap <silent><buffer> K <plug>(YCMHover)
    nnoremap <silent><buffer> gd :YcmCompleter GoTo<CR>
endfunc
