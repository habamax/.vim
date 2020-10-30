if exists("g:loaded_select")
    nmap <space>fe <Plug>(SelectFile)
    nmap <space>fm <Plug>(SelectMRU)
    nmap <space>ff <Plug>(SelectProjectFile)
    nmap <space>fp <Plug>(SelectProject)
    nmap <space>fc <Plug>(SelectColors)
    nmap <space>b <Plug>(SelectBuffer)
    nmap <space>h <Plug>(SelectHelp)
    nmap <space>; <Plug>(SelectCmd)
    nmap <space>/ <Plug>(SelectBufLine)

    let g:select_info = {"session": {}, "highlight": {}}
    let g:select_info.session.data = {-> map(glob("~/.vimdata/sessions/*", 1, 1), {_, v -> fnamemodify(v, ":t")})}
    let g:select_info.session.sink = "%%bd | source ~/.vimdata/sessions/%s"
    let g:select_info.highlight.data = {-> getcompletion('', 'highlight')}
    let g:select_info.highlight.sink = {"action": {v -> feedkeys(':hi '..v.."\<CR>", "nt")}}
    nnoremap <space>fs :Select session<CR>
    nnoremap <space>fh :Select highlight<CR>

    if has("win32")
        let g:select_info.music = {}
        let g:select_info.music.data = {"cmd": "rg --files --glob *.mp3"}
        let g:select_info.music.sink = {"transform": {p, v -> p..v}, "action": {v -> sound_clear() ?? sound_playfile(v)}}

        nnoremap <space>fl :Select music D:/Music<CR>
    endif

    let g:select_info.cmdhistory = {}
    let g:select_info.cmdhistory.data = {-> reverse(filter(map(range(1, histnr("cmd")), {i -> printf("%*d: %s", len(histnr("cmd")), i, histget("cmd", i))}), {i, v -> v !~ '^\s*\d\+:\s*$'}))}
    let g:select_info.cmdhistory.sink = {"transform": {_, v -> matchstr(v, '^\s*\d\+:\s*\zs.*$')}, "action": {v -> feedkeys(':'..v, "nt")}}
    let g:select_info.cmdhistory.highlight = {"PrependBufNr": ['^\(\s*\d\+:\)', 'Identifier']}
    nnoremap <space>: :Select cmdhistory<CR>
endif


if exists("g:loaded_winlayout")
    nmap <F3> <Plug>(WinlayoutBackward)
    nmap <F4> <Plug>(WinlayoutForward)
endif


if exists("g:loaded_swap")
    omap i, <Plug>(swap-textobject-i)
    xmap i, <Plug>(swap-textobject-i)
    omap a, <Plug>(swap-textobject-a)
    xmap a, <Plug>(swap-textobject-a)
    nmap g< <Plug>(swap-prev)
    nmap g> <Plug>(swap-next)
    nmap g. <Plug>(swap-interactive)

    let g:swap#rules = deepcopy(g:swap#default_rules)
    let g:swap#rules += [
                \   {
                \     'description': 'Reorder the space-delimited EN/RU word under the cursor in normal mode.',
                \     'mode': 'n',
                \     'body': '\%([a-zA-Zа-яА-Я[:alnum:]]\+\s*\)\+\%([a-zA-Zа-яА-Я[:alnum:]]\+\)\?',
                \     'delimiter': ['\s\+'],
                \     'priority': -50
                \   },
                \
                \   {
                \     'description': 'Reorder the comma-delimited EN/RU word under the cursor in normal mode.',
                \     'mode': 'n',
                \     'body': '\%([a-zA-Zа-яА-Я[:alnum:]]\+,\s*\)\+\%([a-zA-Zа-яА-Я[:alnum:]]\+\)\?',
                \     'delimiter': ['\s*,\s*'],
                \     'priority': -10
                \   }]
endif
