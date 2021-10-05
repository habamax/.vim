"" Return true if vim is in WSL environment
func! os#is_wsl() abort
    return exists("$WSLENV")
endfunc


"" Return Windows path from WSL
func! os#wsl_to_windows_path(path) abort
    if !os#is_wsl()
        return a:path
    endif

    if !executable('wslpath')
        return a:path
    endif

    let res = systemlist('wslpath -w ' . a:path)
    if !empty(res)
        return res[0]
    else
        return a:path
    endif
endfunc


"" Open explorer(/finder/thunar...) where current file is located
"" Only for win and wsl for now.
func! os#file_manager() abort
    " Windows only for now
    if has("win32") || os#is_wsl()
        if exists("b:netrw_curdir")
            let path = substitute(b:netrw_curdir, "/", "\\", "g")
        elseif exists("b:dirvish")
            let path = getline('.')
        elseif expand("%:p") == ""
            let path = expand("%:p:h")
        else
            let path = expand("%:p")
        endif

        if os#is_wsl()
            let path = os#wsl_to_windows_path(path)
            call job_start(['explorer.exe', '/select,' .. path])
        else
            silent exe '!start explorer.exe /select,' .. path
        endif
    else
        echomsg "Not yet implemented!"
    endif
endfunc


" Better gx to open URLs.
" nnoremap <silent> gx :call os#gx()<CR>
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
        if searchpair('\[.\{-}\](', '', ')\zs', 'cbW', '', line('.')) > 0
            let URL = matchstr(getline('.')[col('.')-1:], '\[.\{-}\](\zs'.rx_embd.'\ze\(\s\+.\{-}\)\?)')
        endif
    finally
        call setpos('.', save_cursor)
    endtry

    " asciidoc URL http://yandex.ru[yandex search]
    if empty(URL)
        try
            let save_cursor = getcurpos()
            if searchpair(rx_bare . '\[', '', '\]\zs', 'cbW', '', line('.')) > 0
                let URL = matchstr(getline('.')[col('.')-1:], '\S\{-}\ze[')
            endif
        finally
            call setpos('.', save_cursor)
        endtry
    endif

    " HTML URL <a href='http://www.python.org'>Python is here</a>
    "          <a href="http://www.python.org"/>
    if empty(URL)
        try
            let save_cursor = getcurpos()
            if searchpair('<a\s\+href=', '', '\%(</a>\|/>\)\zs', 'cbW', '', line('.')) > 0
                let URL = matchstr(getline('.')[col('.')-1:], 'href=["'."'".']\?\zs\S\{-}\ze["'."'".']\?/\?>')
            endif
        finally
            call setpos('.', save_cursor)
        endtry
    endif

    let word = expand("<cWORD>")

    " barebone URL in brackets (http://bla-bla.com)
    "                          <http://bla-bla.com>
    if empty(URL)
        let URL = matchstr(word, '(\zs' . rx_bare . '\ze)')
    endif
    if empty(URL)
        let URL = matchstr(word, '<\zs' . rx_bare . '\ze>')
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
