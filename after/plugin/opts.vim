vim9script

if exists("g:loaded_fugitive")
    command! Gpull Git pull
    command! Gpush Git push
    command! -nargs=* Glog Git log --oneline --decorate --graph <args>
    # Git log --follow -- %
    # Git log -p --follow -- %
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
    nnoremap - <scriptcmd>Dir<cr>
    g:dir_change_cwd = true
    g:dir_actions = [
        {text: 'Share with 0x0.st', Action: (items) => {
            var urls = []
            for item in items
                var path = $"{b:dir_cwd}/{item.name}"
                if item.type != 'dir' && filereadable(path)
                    var url = systemlist($'curl -F file=@"{path}" http://0x0.st')[-1]
                    add(urls, url)
                endif
            endfor
            setreg("@", urls->join("\n"))
            setreg("+", urls->join("\n"))
            echom urls->join("\n")
        }},
        {text: 'Convert to gif', Action: (items) => {
            if len(items) > 1
                return
            endif
            var input = items[0].name
            if fnamemodify(input, ":e") != "mkv"
                echom "Should only work for MKV file!"
                return
            endif
            var output = fnamemodify(input, ":r") .. ".gif"
            var gs_cmd = 'ffmpeg -i "%s" -vf "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" "%s"'
            term_start(printf(gs_cmd, input, output), {term_finish: "close"})
            # if v:shell_error
            #     echom $"Couldn't convert {input}"
            # else
            #     :Dir
            # endif
        }},
        {text: 'Optimize PDF', Action: (items) => {
            if len(items) > 1
                return
            endif
            var input = items[0].name
            if fnamemodify(input, ":e") != "pdf"
                echom "Should only work for PDF file!"
                return
            endif
            var output = fnamemodify(input, ":r") .. "_opt.pdf"
            var gs_cmd = 'gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="%s" "%s"'
            system(printf(gs_cmd, output, input))
            if v:shell_error
                echom $"Couldn't optimize {input}"
            else
                :Dir
            endif
        }},
        # {text: 'Check vim screen dump', Action: (items) => {
        #     if len(items) > 1
        #         return
        #     endif
        #     # TODO: check for path, name and extension: failed/Test_.*\.dump
        #     term_dumpdiff(items[0].name, $"../dumps/{items[0].name}")
        # }},
    ]
endif

# vim-shout
if exists("g:loaded_shout")
    import autoload "shout.vim"
    nnoremap <F4> <scriptcmd>shout.CloseWindow()<CR>
    nnoremap \e <scriptcmd>shout.NextErrorJump()<CR>
    nnoremap \E <scriptcmd>shout.LastErrorJump()<CR>
    nnoremap \r <scriptcmd>shout.PrevErrorJump()<CR>
    nnoremap \R <scriptcmd>shout.FirstErrorJump()<CR>
endif

if exists("g:loaded_lsp")
    g:LspOptionsSet({
        useBufferCompletion: true,
        completionMatcher: 'fuzzy',
        completionTextEdit: false,
        showInlayHints: true,
        showDiagOnStatusLine: false,
        showDiagWithVirtualText: false,
        autoPopulateDiags: true,
    })
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
        }])
    endif
endif

if exists("g:loaded_vimcomplete")
    g:VimCompleteInfoWindowOptionsSet({
        drag: false,
        close: 'none',
        resize: false,
        borderchars: g:popup_borderchars,
    })
endif
