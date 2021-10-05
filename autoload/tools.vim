" Redirect the output of a Vim command into a scratch buffer
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


" Better gx to open URLs.
" nnoremap <silent> gx :call tools#gx()<CR>
func! tools#gx() abort
    if has("win32") || has("win32unix")
        let cmd = ':silent !start'
    elseif has("osx")
        let cmd = ":!open"
    elseif exists("$WSLENV")
        let cmd = ":silent !cmd.exe /C start"
    else
        let cmd = ":!xdg-open"
    endif

    " URL regexes
    let rx_base = '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S'
    let rx_bare = rx_base . '\+'
    let rx_embd = rx_base . '\{-}'

    let URL = ""

    " markdown URL [link text](http://ya.ru 'yandex search')
    try
        let save_cursor = getcurpos()
        if searchpair('\[.\{-}\](', '', ')', 'cbW', '', line('.')) > 0
            let URL = matchstr(getline('.')[col('.')-1:], '\[.\{-}\](\zs'.rx_embd.'\ze\(\s\+.\{-}\)\?)')
            echom "markdown"
        endif
    finally
        call setpos('.', save_cursor)
    endtry

    " asciidoc URL http://yandex.ru[yandex search]
    if empty(URL)
        try
            let save_cursor = getcurpos()
            if searchpair(rx_bare . '\[', '', '\]', 'cbW', '', line('.')) > 0
                let URL = matchstr(getline('.')[col('.')-1:], '\S\{-}\ze[')
            endif
        finally
            call setpos('.', save_cursor)
        endtry
    endif

    let word = expand("<cWORD>")

    " barebone URL in brackets (http://bla-bla.com)
    if empty(URL)
        let URL = matchstr(word, '(\zs' . rx_bare . '\ze)')
    endif

    " barebone URL ending with comma or dot http://bla-bla.com, http://bla-bla.com.
    if empty(URL)
        let URL = matchstr(word, rx_bare . '\ze[.,]\(\s\|$\)')
    endif

    " barebone URL http://bla-bla.com
    if empty(URL)
        let URL = matchstr(word, rx_bare)
    endif

    if empty(URL)
        return
    endif

    exe cmd . ' "' . escape(URL, '#%!')  . '"'
endfunc
