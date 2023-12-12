vim9script

if exists("g:loaded_fugitive")
    command! Glog Git log -p --follow -- %
    command! GlogSummary Git log --follow -- %
    command! Gpull Git pull
    command! Gpush Git push
endif


if exists("g:loaded_swap")
    omap io <Plug>(swap-textobject-i)
    xmap io <Plug>(swap-textobject-i)
    omap ao <Plug>(swap-textobject-a)
    xmap ao <Plug>(swap-textobject-a)
endif


if exists("g:loaded_checkbox")
    xmap <space>x  <Plug>(CheckboxToggleOp)
    nmap <space>x  <Plug>(CheckboxToggleOp)
    omap <space>x  <Plug>(CheckboxToggleOp)
    nmap <space>xx <Plug>(CheckboxToggleLineOp)
endif


if exists("g:loaded_guifont_size")
    nmap <C-=> <Plug>(GUIFontSizeInc)
    nmap <C-_> <Plug>(GUIFontSizeDec)
    nmap <C--> <Plug>(GUIFontSizeDec)
    nmap <C-0> <Plug>(GUIFontSizeRestore)
endif


if exists("g:loaded_dir")
    nnoremap <bs> <scriptcmd>Dir<cr>
endif


if exists("g:loaded_lsp")
    g:LspAddServer([{
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: '/usr/bin/clangd',
        args: ['--background-index']
    }])
    g:LspAddServer([{
        name: 'pylsp',
        filetype: ['python'],
        path: 'pylsp'
    }])

    # TODO: should only be enabled for the modes where lsp is up and running
    nnoremap <space>lh <scriptcmd>LspHover<CR>
    nnoremap <space>gd <scriptcmd>LspGotoDefinition<CR>
endif
