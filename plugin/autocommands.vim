vim9script

# Autocommands

# turn off hlsearch after:
# - doing nothing for 'updatetime'
# - getting into insert mode
augroup auto_nohlsearch | au!
    set updatetime=2000
    noremap <Plug>(nohlsearch) <cmd>nohlsearch<cr>
    noremap! <expr> <Plug>(nohlsearch) execute('nohlsearch')[-1]
    au CursorHold * call feedkeys("\<Plug>(nohlsearch)", 'm')
    au InsertEnter * call feedkeys("\<Plug>(nohlsearch)", 'm')
augroup END

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
