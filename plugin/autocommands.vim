vim9script

# Autocommands


augroup general | au!
    au Filetype * setl formatoptions=qjlron

    # auto :nohlsearch
    set updatetime=2000
    noremap! <expr> <Plug>(nohlsearch) execute('nohlsearch')[-1]
    au CursorHold * call feedkeys("\<Plug>(nohlsearch)", 'm')
    au InsertEnter * call feedkeys("\<Plug>(nohlsearch)", 'm')

    # goto last known position of the buffer
    au BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          |    exe 'normal! g`"'
          | endif

    # create non-existent directory before buffer save
    au BufWritePre *
          \ if !isdirectory(expand("%:p:h"))
          |    call mkdir(expand("%:p:h"), "p")
          | endif

    au VimLeavePre * :exe $'mksession! {g:vimdata}/sessions/LAST'
augroup end
