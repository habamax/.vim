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
    g:dir_actions = [
        {text: 'Share with 0x0.st', Action: (selection, marks) => {
            var items = []
            if marks->len() > 0
                items = marks
            else
                items = selection
            endif
            var urls = []
            for item in items
                if item.type != 'dir' && filereadable(item.name)
                    var url = systemlist($'curl -F file=@"{item.name}" http://0x0.st')[-1]
                    add(urls, url)
                endif
            endfor
            setreg("@", urls->join("\n"))
            setreg("+", urls->join("\n"))
            echom urls->join("\n")
        }}
    ]
endif

if exists("g:loaded_lsp")
    if executable('clangd')
        g:LspAddServer([{
            name: 'clangd',
            filetype: ['c', 'cpp'],
            path: 'clangd',
            args: ['--background-index']
        }])
    endif
    if executable('pylsp')
        g:LspAddServer([{
            name: 'pylsp',
            filetype: ['python'],
            path: 'pylsp'
        }])
    endif
    if executable('netcat')
        g:LspAddServer([{
            name: 'gdscript',
            filetype: ['gdscript'],
            path: 'netcat',
            args: ['127.0.0.1', '6008'],
            features: {
                completion: false,
                diagnostics: false,
            }
        }])
    endif
endif
