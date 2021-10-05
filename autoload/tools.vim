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

    " by default check WORD under cursor
    let word = expand("<cWORD>")

    " Asciidoc URL
    " if cursor is surrounded by [   ], like for http://ya.ru[yandex search]
    " take a cWORD from first char before [
    let save_cursor = getcurpos()
    let line = getline('.')
    if searchpair('\[', '', '\]', 'b', '', line('.')) 
        let word = expand("<cWORD>")
    endif
    call setpos('.', save_cursor)

    " Asciidoc URL http://bla-bla.com[desc
    let aURL = matchstr(word, '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S\+\ze\[')
    if aURL != ""
        exe cmd . ' "' . escape(aURL, '#%!')  . '"'
        return
    endif

    " Check asciidoc link link:file.txt[desc
    let aLNK = matchstr(word, 'link:/*\zs\S\+\ze\[')
    if aLNK != ""
        execute "lcd ". expand("%:p:h")
        exe cmd . ' ' . fnameescape(fnamemodify(aLNK, ":p"))
        lcd -
        return
    endif

    " barebone URL http://bla-bla.com
    let URL = matchstr(word, '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S\+')
    if URL != ""
        exe cmd . ' "' . escape(URL, '#%!')  . '"'
        return
    endif

    " probably path?
    if word =~ '^[~.$].*'
        exe cmd . ' ' . expand(word)
        return
    endif

    try
        exe "normal! gf"
    catch /E447/
        echohl Error
        echomsg matchstr(v:exception, 'Vim(normal):\zs.*$')
        echohl None
    endtry
endfunc
