" Redirect the output of a Vim or external command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" Usage:
" Add command to your vimrc
" command! -nargs=1 -complete=command -bar -range Redir silent call tools#redir(<q-args>, <range>, <line1>, <line2>)
" To use:
" :Redir version
" Vim version would be in a new window
func! tools#redir(cmd, rng, start, end) abort
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        let cmd = a:cmd =~' %'
                    \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
                    \ : matchstr(a:cmd, '^!\zs.*')
        if a:rng == 0
            let output = systemlist(cmd)
        else
            let joined_lines = join(getline(a:start, a:end), '\n')
            let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
            let output = systemlist(cmd . " <<< $" . cleaned_lines)
        endif
    else
        redir => output
        execute a:cmd
        redir END
        let output = split(output, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunc
