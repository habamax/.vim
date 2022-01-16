vim9script

if exists("g:loaded_select")
    nmap <space>f <Plug>(SelectFile)
    nmap <space>sm <Plug>(SelectMRU)
    nmap <space>sf <Plug>(SelectProjectFile)
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

    g:select_info = get(g:, "select_info", {})

    g:select_info.session = {}
    g:select_info.session.data = (..._) => map(glob("~/.vimdata/sessions/*", 1, 1), (_, v) => fnamemodify(v, ":t"))
    g:select_info.session.sink = "%%bd | source ~/.vimdata/sessions/%s"
    nnoremap <silent> <space>ss :Select session<CR>

    def s:template_data(buf: dict<any>): list<string>
        var path = fnamemodify($MYVIMRC, ':p:h') .. '/templates/'
        var ft = getbufvar(buf.bufnr, '&filetype')
        var ft_path = path .. ft
        var tmpls = []

        if !empty(ft) && isdirectory(ft_path)
            tmpls = mapnew(readdirex(ft_path, (e) => e.type == 'file'), (_, v) => ft .. '/' .. v.name)
        endif

        if isdirectory(path)
            extend(tmpls, mapnew(readdirex(path, (e) => e.type == 'file'), (_, v) => v.name))
        endif

        return tmpls
    enddef

    def s:template_sink(tfile: string)
        append(line('.'), readfile(tfile))
        if getline('.') =~ '^\s*$'
            del _
        else
            normal! j^
        endif
    enddef

    g:select_info.template = {}
    g:select_info.template.data = (_, buf) => s:template_data(buf)
    g:select_info.template.sink = {
        transform: (_, v) => fnameescape(fnamemodify($MYVIMRC, ':p:h') .. '/templates/' .. v),
        action: (v) => s:template_sink(v)
    }
    g:select_info.template.highlight = {"DirectoryPrefix": ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}
    nnoremap <silent> <space>i :Select template<CR>

    def s:tag_data(): list<string>
        var result = []
        if !filereadable('tags') 
            return result
        endif
        for line in readfile('tags')
            if line =~ '^!_TAG' | continue | endif
            var info = split(line, "\t")
            call add(result, printf("%s\t%-30S\t%s", info[3], info[0], info[1]))
        endfor
        return result
    enddef
    g:select_info.tag = {}
    g:select_info.tag.data = (..._) => s:tag_data()
    g:select_info.tag.sink = "tag %s"
    g:select_info.tag.sink = {
        transform: (_, v) => split(v, "\t")[1],
        action: (v) => {
            exe "tag " .. escape(v, '"')
        }
    }
    g:select_info.tag.highlight = {
        DirectoryPrefix: ['\t\zs.\S\+$', 'Comment'],
        TagType: ['^\a', 'Type']
    }
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

    g:swap#rules = deepcopy(g:swap#default_rules)
    g:swap#rules += [
        {
            mode: 'n',
            description: 'Reorder the | bar | delimited | things |.',
            body: '|\%([^|]\+|\)\+',
            delimiter: ['\s*|\s*'],
            priority: -40
        },
        {
            description: 'Reorder the space-delimited EN/RU word under the cursor in normal mode.',
            mode: 'n',
            body: '\%([a-zA-Zа-яА-Я[:alnum:]]\+\s*\)\+\%([a-zA-Zа-яА-Я[:alnum:]]\+\)\?',
            delimiter: ['\s\+'],
            priority: -50
        },
        {
            description: 'Reorder the comma-delimited EN/RU word under the cursor in normal mode.',
            mode: 'n',
            body: '\%([a-zA-Zа-яА-Я[:alnum:]]\+,\s*\)\+\%([a-zA-Zа-яА-Я[:alnum:]]\+\)\?',
            delimiter: ['\s*,\s*'],
            priority: -10
        }
    ]
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


if exists("g:loaded_netrwPlugin")
    g:netrw_banner = 0
endif
