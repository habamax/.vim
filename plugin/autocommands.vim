vim9script

# Autocommands


augroup general | au!
    au CmdlineEnter /,\? set hlsearch
    au CmdlineLeave /,\? set nohlsearch

    au Filetype * setl formatoptions=qjl

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
