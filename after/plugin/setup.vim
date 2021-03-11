if exists("g:loaded_select")
    nmap <space>fe <Plug>(SelectFile)
    nmap <space>fm <Plug>(SelectMRU)
    nmap <space>ff <Plug>(SelectProjectFile)
    nmap <space>fp <Plug>(SelectProject)
    nmap <space>b  <Plug>(SelectBuffer)

    if exists("g:loaded_select_more")
        nmap <space>fc <Plug>(SelectColors)
        nmap <space>h  <Plug>(SelectHelp)
        nmap <space>:  <Plug>(SelectCmd)
        nmap <space>gg <Plug>(SelectBufLine)
        nmap <space>fh <Plug>(SelectHighlight)
        nmap <space>;  <Plug>(SelectCmdHistory)
        nmap <space>ta <Plug>(SelectBufTag)
        nmap <space>fg <Plug>(SelectGitFile)
        nmap <space>to <Plug>(SelectToDo)
    endif

    nnoremap <silent> <space>fi :exe "Select projectfile " .. fnamemodify($MYVIMRC, ":p:h")<cr>

    let g:select_info = get(g:, "select_info", {})

    let g:select_info.session = {}
    let g:select_info.session.data = {-> map(glob("~/.vimdata/sessions/*", 1, 1), {_, v -> fnamemodify(v, ":t")})}
    let g:select_info.session.sink = "%%bd | source ~/.vimdata/sessions/%s"
    nnoremap <silent> <space>fs :Select session<CR>

    if has("win32")
        func! s:play_in_vlc(v)
            let mp3 = shellescape(substitute(a:v, '/', '\\', 'g'))
            call job_start('vlc '..mp3)
        endfunc
        let g:select_info.music = {}
        let g:select_info.music.data = {"job": "rg --path-separator / --files --glob *.mp3"}
        " let g:select_info.music.sink = {"transform": {p, v -> p..v}, "action": {v -> sound_clear() ?? sound_playfile(v)}}
        let g:select_info.music.sink = {"transform": {p, v -> p..v}, "action": {v -> s:play_in_vlc(v)}}
        let g:select_info.music.highlight = {"DirectoryPrefix": ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}
        nnoremap <space>fu :Select music D:/Music<CR>
    endif


    let g:select_info.template = {}
    let g:select_info.template.data = {_, buf -> s:template_data(buf)}
    let g:select_info.template.sink = {
            \ "transform": {_, v -> fnameescape(fnamemodify($MYVIMRC, ':p:h') .. '/templates/' .. v)},
            \ "action": {v -> s:template_sink(v)}
            \ }
    let g:select_info.template.highlight = {"DirectoryPrefix": ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}

    func! s:template_data(buf) abort
        let path = fnamemodify($MYVIMRC, ':p:h') .. '/templates/'
        let ft = getbufvar(a:buf.bufnr, '&filetype')
        let ft_path = path .. ft
        let tmpls = []

        if !empty(ft) && isdirectory(ft_path)
            let tmpls = map(readdirex(ft_path, {e -> e.type == 'file'}), {_, v -> ft .. '/' .. v.name})
        endif

        if isdirectory(path)
            call extend(tmpls, map(readdirex(path, {e -> e.type == 'file'}), {_, v -> v.name}))
        endif

        return tmpls
    endfunc
    func! s:template_sink(tfile) abort
        exe "keepalt read "..a:tfile
        :'[,']s/!!\(.\{-}\)!!/\=eval(submatch(1))/ge
    endfunc

    nnoremap <silent> <space>te :Select template<CR>
endif


if exists("g:loaded_winlayout")
    nmap <F3> <Plug>(WinlayoutBackward)
    nmap <F4> <Plug>(WinlayoutForward)
endif


if exists("g:loaded_swap")
    omap io <Plug>(swap-textobject-i)
    xmap io <Plug>(swap-textobject-i)
    omap ao <Plug>(swap-textobject-a)
    xmap ao <Plug>(swap-textobject-a)
    nmap g< <Plug>(swap-prev)
    nmap g> <Plug>(swap-next)
    nmap g. <Plug>(swap-interactive)

    let g:swap#rules = deepcopy(g:swap#default_rules)
    let g:swap#rules += [
                \   {
                \     'mode': 'n',
                \     'description': 'Reorder the | bar | delimited | things |.',
                \     'body': '|\%([^|]\+|\)\+',
                \     'delimiter': ['\s*|\s*'],
                \     'priority': -40
                \   },
                \
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
                \   }
                \ ]
endif


if exists("g:loaded_fern")
    nnoremap <silent> <F8> :Fern . -drawer -toggle -reveal=%<CR>
    nnoremap <silent> <F9> :FernDo :<CR>
endif


if exists("g:loaded_listopad")
    "" listopad
    let g:listopad_auto_archive = 1
    xmap <space>x  <Plug>(ListopadToggleCheckboxOp)
    nmap <space>x  <Plug>(ListopadToggleCheckboxOp)
    omap <space>x  <Plug>(ListopadToggleCheckboxOp)
    nmap <space>xx <Plug>(ListopadToggleCheckboxLineOp)
endif


if exists("g:loaded_easy_align_plugin")
    vmap ga <Plug>(LiveEasyAlign)
    nmap ga <Plug>(EasyAlign)
endif


if exists("g:loaded_guifont_size")
    nmap <A-=> <Plug>(GUIFontSizeInc)
    nmap <A--> <Plug>(GUIFontSizeDec)
    nmap <A-0> <Plug>(GUIFontSizeRestore)
endif
