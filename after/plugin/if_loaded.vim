vim9script

if exists("g:loaded_fugitive")
    command! -nargs=* Glog Git log --oneline --decorate --graph <args>
    # Git log --follow -- %
    # Git log -p --follow -- %
endif

if exists("g:loaded_surround")
    nmap <space>s <Plug>(surround-word-add)
    xmap <space>s <Plug>(surround-add)
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
                    var url = systemlist($'curl -A "Vim Paste" -F file=@"{path}" http://0x0.st')[-1]
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
        {text: 'Compare vim screendumps', Action: (items) => {
            if len(items) > 1
                return
            endif
            mess clear
            var failed = $"{b:dir_cwd}/{items[0].name}"
            if b:dir_cwd !~ 'failed$'
                echom "Should only work for vim screendump file!"
                return
            endif
            var dump = fnamemodify(failed, ":s/failed/dumps/")
            term_dumpdiff(failed, dump)
        }},
    ]
endif

if exists("g:loaded_lsp")
    g:LspOptionsSet({
        autoComplete: false,
        filterCompletionDuplicates: true,
        completionMatcher: 'fuzzy',
        usePopupInCodeAction: true,
        showInlayHints: false,
        showDiagOnStatusLine: false,
        showDiagWithVirtualText: true,
        diagVirtualTextAlign: 'after',
        diagSignErrorText: '✘',
        diagSignWarningText: '•',
        diagSignHintText: '§',
        diagSignInfoText: 'ℹ',
        autoPopulateDiags: true,
        popupBorder: true,
        # popupHighlight: 'Normal',
        popupBorderHighlight: 'PmenuBorder',
    })
endif

if exists("g:loaded_copilot")
    # vim-copilot
    import autoload "qc.vim"
    imap <C-g> <scriptcmd>qc.Copilot()<CR>
endif
