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

    def TemplateData(buf: dict<any>): list<string>
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

    def TemplateSink(tfile: string)
        append(line('.'), readfile(tfile))
        if getline('.') =~ '^\s*$'
            del _
        else
            normal! j^
        endif
    enddef

    g:select_info.template = {}
    g:select_info.template.data = (_, buf) => TemplateData(buf)
    g:select_info.template.sink = {
        transform: (_, v) => fnameescape(fnamemodify($MYVIMRC, ':p:h') .. '/templates/' .. v),
        action: (v) => TemplateSink(v)
    }
    g:select_info.template.highlight = {"DirectoryPrefix": ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}
    nnoremap <silent> <space>i :Select template<CR>

    def TagData(): list<string>
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
    g:select_info.tag.data = (..._) => TagData()
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

    g:select_info.bookmark = {}
    g:select_info.bookmark.data = (..._) => readfile(expand("~/.vimdata/bookmarks"))
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
        var bookmarkFile = expand("~/.vimdata/bookmarks")
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
    nmap <A-=> <Plug>(GUIFontSizeInc)
    nmap <A--> <Plug>(GUIFontSizeDec)
    nmap <A-0> <Plug>(GUIFontSizeRestore)
endif


if exists("g:loaded_netrwPlugin")
    g:netrw_banner = 0
endif


if exists(":Limelight") == 2
    g:limelight_default_coefficient = 0.8
endif
