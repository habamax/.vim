if exists("g:loaded_select")
    nmap <space>e <Plug>(SelectFile)
    nmap <space>sm <Plug>(SelectMRU)
    nmap <space>f <Plug>(SelectProjectFile)
    nmap <space>sp <Plug>(SelectProject)
    nmap <space>b  <Plug>(SelectBuffer)

    nnoremap <space>s <nop>
    if exists("g:loaded_select_more")
        nmap <space>sc <Plug>(SelectColors)
        nmap <space>h  <Plug>(SelectHelp)
        nmap <space>:  <Plug>(SelectCmd)
        nmap <space>sl <Plug>(SelectBufLine)
        nmap <space>sh <Plug>(SelectHighlight)
        nmap <space>;  <Plug>(SelectCmdHistory)
        nmap <space>st <Plug>(SelectBufTag)
        nmap <space>sg <Plug>(SelectGitFile)
        nmap <space>to <Plug>(SelectToDo)
    endif

    nnoremap <silent> <space>sv :exe "Select gitfile " .. fnamemodify($MYVIMRC, ":p:h")<cr>

    let g:select_info = get(g:, "select_info", {})

    let g:select_info.session = {}
    let g:select_info.session.data = {-> map(glob("~/.vimdata/sessions/*", 1, 1), {_, v -> fnamemodify(v, ":t")})}
    let g:select_info.session.sink = "%%bd | source ~/.vimdata/sessions/%s"
    nnoremap <silent> <space>ss :Select session<CR>

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
        let tlines = readfile(a:tfile)
                    \->map({_, v, -> substitute(v, '!!\(.\{-}\)!!', '\=eval(submatch(1))', 'g')})
        call append(line('.'), tlines)
        if getline('.') =~ '^\s*$'
            del _
        else
            normal! j^
        endif
    endfunc

    nnoremap <silent> <space>i :Select template<CR>

    let g:select_info.tag = {}
    let g:select_info.tag.data = {-> s:tag_data()}
    let g:select_info.tag.sink = "tag %s"
    let g:select_info.tag.sink = {
            \ "transform": {_, v -> split(v, "\t")[1]},
            \ "action": {v -> s:tag_sink(v)}
            \ }
    let g:select_info.tag.highlight = {
          \ "DirectoryPrefix": ['\t\zs.\S\+$', 'Comment'],
          \ "TagType": ['^\a', 'Type']
          \ }
    func! s:tag_data() abort
        if !filereadable('tags') | return | endif
        let result = []
        for line in readfile('tags')
            if line =~ '^!_TAG' | continue | endif
            let info = split(line, "\t")
            call add(result, printf("%s\t%-30S\t%s", info[3], info[0], info[1]))
        endfor
        return result
    endfunc
    func! s:tag_sink(value) abort
        exe "tag " . escape(a:value, '"')
    endfunc
    nnoremap <silent> <space>sT :Select tag<CR>
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


if exists("g:loaded_checkbox")
    xmap <space>x  <Plug>(CheckboxToggleOp)
    nmap <space>x  <Plug>(CheckboxToggleOp)
    omap <space>x  <Plug>(CheckboxToggleOp)
    nmap <space>xx <Plug>(CheckboxToggleLineOp)
endif


if exists("g:loaded_guifont_size")
    nmap <A-=> <Plug>(GUIFontSizeInc)
    nmap <A--> <Plug>(GUIFontSizeDec)
    nmap <A-0> <Plug>(GUIFontSizeRestore)
endif


if exists("g:loaded_surround")
    let g:surround_{char2nr('c')} = "\\\1latex\1{\r}"
endif



" netrw
if exists("g:loaded_netrwPlugin")
    func! s:netrw_e() abort
        exe 'silent e ' .. expand("%:p:h")
        call search('\<'..expand("#:t")..'\>')
    endfunc
    nnoremap <silent> - :call <SID>netrw_e()<CR>
    let g:netrw_banner = 0
endif

