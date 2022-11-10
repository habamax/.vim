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
endif


if exists("g:loaded_ale")
    nnoremap ]e :ALENext<CR>
    nnoremap [e :ALEPrevious<CR>
    imap <C-@> <Plug>(ale_complete)
    imap <C-Space> <Plug>(ale_complete)
    g:ale_floating_preview = 1
    g:ale_floating_preview_popup_opts = 1
    g:ale_floating_window_border = ['│', '─', '┌', '┐', '┘', '└', '│', '─']
    g:ale_pattern_options = {'\.tex$': {ale_enabled: 0}}
    g:ale_floating_preview_popup_opts = {
        highlight: get(g:, "popuphighlight", ''),
        close: 'none',
        filter: (winid, key) => {
            if key == "\<Space>"
                win_execute(winid, "normal! \<C-d>\<C-d>")
                return true
            elseif key == "j"
                win_execute(winid, "normal! \<C-d>")
                return true
            elseif key == "k"
                win_execute(winid, "normal! \<C-u>")
                return true
            elseif key == "g"
                win_execute(winid, "normal! gg")
                return true
            elseif key == "G"
                win_execute(winid, "normal! G")
                return true
            endif
            if key == "\<ESC>"
                popup_close(winid)
                return true
            endif
            return true
        }
    }
    ale#linter#Define('gdscript', {
        'name': 'godot',
        'lsp': 'socket',
        'address': '127.0.0.1:6008',
        'project_root': 'project.godot',
    })
endif
