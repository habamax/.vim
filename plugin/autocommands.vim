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

    au VimLeavePre * :exe $'mksession! {fnamemodify($MYVIMRC, ":p:h")}/.data/sessions/LAST'
augroup end
