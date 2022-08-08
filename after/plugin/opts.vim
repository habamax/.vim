vim9script

if exists("g:loaded_select")
    g:select_info = get(g:, "select_info", {})


    g:select_info.bookmark = {}
    g:select_info.bookmark.data = (..._) => readfile($'{g:vimdata}/bookmarks')
    g:select_info.bookmark.sink = {
        transform: (_, v) => split(v, "\t")[1],
        action: (v) => {
            var vals = split(v, "|")
            exe "confirm e" vals[0]
            if len(vals) == 3
                exe ":" vals[1]
                exe "normal!" .. vals[2] .. "|"
            endif
        }
    }
    g:select_info.bookmark.highlight = {
        DirectoryPrefix: ['\t\zs.\S\+$', 'Comment']
    }
    nnoremap <silent> <space>sb :Select bookmark<CR>
    def SaveBookmark()
        if empty(expand("%")) | return | endif
        var name = input("Save bookmark: ", expand("%:t"))
        if empty(name)
            name = expand("%:t")
        endif
        var bookmarkFile = $'{g:vimdata}/bookmarks'
        var bookmarks = []
        var bookmark = printf("%s\t%s|%s|%s", name, expand("%:p"), line('.'), col('.'))
        if filereadable(bookmarkFile)
            bookmarks = readfile(bookmarkFile)
        endif
        add(bookmarks, bookmark)
        writefile(bookmarks, bookmarkFile)
    enddef
    command! Bookmark call SaveBookmark()
endif


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
    nmap <C-0> <Plug>(GUIFontSizeRestore)
endif


if exists("g:loaded_dir")
    nnoremap <bs> <scriptcmd>Dir<cr>
endif


if exists("g:loaded_ale")
    nnoremap ]e :ALENext<CR>
    nnoremap [e :ALEPrevious<CR>
endif
