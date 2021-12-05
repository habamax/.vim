" Redirect the output of a Vim command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" Usage:
" Add command to your vimrc
" command! -nargs=1 -complete=command Redir silent call tools#redir(<q-args>)
" To use:
" :Redir version
" Vim version would be in a new window
func! v#redir(cmd) abort
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if version > 704
        let output = split(execute(a:cmd), "\n")
    else
        redir => redir_out
        exe a:cmd
        redir END
        let output = split(redir_out, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunc


" Helper notification function
func! v#popup(...) abort
    call popup_notification(call("printf", a:000), {})
endfunc


" Loggers
func! s:logger(kind, ...) abort
    let logfile = expand("~/.vimdata/vim".strftime("%Y%m%d").".log")
    let logline = printf("%s - %s - %s: %s", strftime("%H:%M:%S"), expand("%:p"), a:kind, call("printf", a:000))
    call writefile([logline], logfile, "a")
endfunc

func! v#log(...) abort
    call call("s:logger", ["DEBUG"] + a:000)
endfunc

func! v#logi(...) abort
    call call("s:logger", ["INFO"] + a:000)
endfunc

func! v#loge(...) abort
    call call("s:logger", ["ERROR"] + a:000)
endfunc

func! v#logw(...) abort
    call call("s:logger", ["WARNING"] + a:000)
endfunc
