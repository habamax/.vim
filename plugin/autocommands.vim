vim9script

# Autocommands

augroup general | au!
    au Filetype * setl formatoptions=qjlron

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

    # save last session on exit if there is a buffer with name
    au VimLeavePre *
          \ if reduce(getbufinfo({'buflisted': 1}), (a, v) => a || !empty(v.name), false)
          |    :exe $'mksession! {$MYVIMDIR}/.data/sessions/LAST'
          | endif
augroup end
