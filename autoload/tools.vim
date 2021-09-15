" Redirect the output of a Vim or external command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" Usage:
" Add command to your vimrc
" command! -nargs=1 -complete=command Redir silent call tools#redir(<q-args>)
" To use:
" :Redir version
" Vim version would be in a new window
func! tools#redir(cmd) abort
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        let cmd = a:cmd =~' %'
                    \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
                    \ : matchstr(a:cmd, '^!\zs.*')
        let output = systemlist(cmd)
    else
        if version > 704
            let output = split(execute(a:cmd), "\n")
        else
            redir => redir_out
            exe a:cmd
            redir END
            let output = split(redir_out, "\n")
        endif
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunc
