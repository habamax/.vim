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
    nmap g< <Plug>(swap-prev)
    nmap g> <Plug>(swap-next)
    nmap g. <Plug>(swap-interactive)

    g:swap#rules = deepcopy(g:swap#default_rules)
    g:swap#rules += [
        {
            mode: 'n',
            description: 'Reorder the | bar | delimited | things |.',
            body: '|\zs\%([^|]\+|\s*\)\+\%([^|]\+\)',
            delimiter: ['\s*|\s*'],
            priority: 0
        },
        {
            description: 'Reorder the space-delimited things.',
            mode: 'n',
            body: '\%([^[:space:]]\+\s*\)\+\%([^[:space:]]\+\)\?',
            delimiter: ['\s\+'],
            priority: -49
        },
        {
            description: 'Reorder the comma-delimited things.',
            mode: 'n',
            body: '\%([^,]*,\s*\)\+\%([^,]*\)',
            delimiter: ['\s*,\s*'],
            priority: -5
        },
    ]
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


if exists("g:loaded_ale")
    nnoremap ]e :ALENext<CR>
    nnoremap [e :ALEPrevious<CR>
endif


# Coc has a *very* slow startup time in Windows
if has("win32")
    g:coc_start_at_startup = 0
endif
packadd coc
if exists(":CocStart") == 2 && !get(g:, "coc_start_at_startup", 1)
    timer_start(2000, (_) => {
        CocStart
    })
endif
if exists("g:did_coc_loaded")
    def CocTab(): string
        if coc#pum#visible() | return coc#pum#confirm() | endif
        if col('.') > 1 && getline('.')[col('.') - 2] !~# '\s'
            return coc#refresh()
        endif
        return "\<tab>"
    enddef
    inoremap <silent><expr> <tab> CocTab()
endif
