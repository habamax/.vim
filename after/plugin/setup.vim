if exists("g:loaded_select")
    nmap <leader>fo <Plug>(SelectFile)
    nmap <leader>fm <Plug>(SelectMRU)
    nmap <leader>ff <Plug>(SelectProjectFile)
    nmap <leader>fp <Plug>(SelectProject)
    nmap <leader>fc <Plug>(SelectColors)
    nmap <leader>b <Plug>(SelectBuffer)
    nmap <leader>h <Plug>(SelectHelp)
    nmap <leader>; <Plug>(SelectCmd)

    """ vim-select {{{1
    let g:select_info = {"session": {}, "sound": {}, "highlight": {}}
    let g:select_info.session.data = {-> map(glob("~/.vimdata/sessions/*", 1, 1), {_, v -> fnamemodify(v, ":t")})}
    let g:select_info.session.sink = "%%bd | source ~/.vimdata/sessions/%s"
    let g:select_info.sound.data = {"cmd": "rg --files --glob *.mp3"}
    let g:select_info.sound.sink = {"transform": {p, v -> p..v}, "action": {v -> sound_playfile(v)}}
    let g:select_info.sound.data = {"cmd": "rg --files --glob *.mp3"}
    let g:select_info.sound.sink = {"transform": {p, v -> p..v}, "action": {v -> sound_playfile(v)}}
    let g:select_info.highlight.data = {-> getcompletion('', 'highlight')}
    let g:select_info.highlight.sink = {"action": {v -> feedkeys(':hi '..v.."\<CR>", "nt")}}
    nnoremap <leader>fs :Select session<CR>
    nnoremap <leader>fh :Select highlight<CR>
endif


if exists("g:loaded_winlayout")
    nmap <F3> <Plug>(WinlayoutBackward)
    nmap <F4> <Plug>(WinlayoutForward)
endif


if exists("g:loaded_swap") " {{{1
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
