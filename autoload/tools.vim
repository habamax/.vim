" Redirect the output of a Vim or external command into a scratch buffer
" Usage:
" Add command to your vimrc
" command! -nargs=1 Redir silent call tools#redir(<f-args>)
" To use:
" :Redir version
" Vim version would be in a new window
func! tools#redir(cmd) abort
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    vnew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    let w:scratch = 1

    let output = execute(a:cmd)
    call setline(1, split(output, "\n"))
endfunc
