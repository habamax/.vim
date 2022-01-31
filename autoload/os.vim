vim9script


# Return true if vim is in WSL environment
export def IsWsl(): bool
    return exists("$WSLENV")
enddef


# Return Windows path from WSL
export def WslToWindowsPath(path: string): string
    if !IsWsl()
        return path
    endif

    if !executable('wslpath')
        return path
    endif

    var res = systemlist('wslpath -w ' .. path)
    if !empty(res)
        return res[0]
    else
        return path
    endif
enddef


# Open explorer(/finder/thunar...) where current file is located
# Only for win and wsl for now.
export def FileManager()
    var path = ''
    # Windows only for now
    if executable("cmd.exe")
        if exists("b:netrw_curdir")
            path = substitute(b:netrw_curdir, "/", "\\", "g")
        elseif exists("b:dirvish")
            path = getline('.')
        elseif expand("%:p") == ""
            path = expand("%:p:h")
        else
            path = expand("%:p")
        endif

        var job_opts = {}
        if IsWsl()
            path = escape(WslToWindowsPath(path), '\')
            job_opts.cwd = "/mnt/c"
        endif
        job_start('cmd.exe /c start explorer.exe /select,' .. path, job_opts)
    else
        echomsg "Not yet implemented!"
    endif
enddef


# Silently execute OS command
export def Exe(cmd: string)
    var runner = ''
    if executable('cmd.exe')
        runner = 'cmd.exe /C start ""'
    elseif executable('xdg-open')
        runner = "xdg-open"
    elseif executable('open')
        runner = "open"
    else
        echohl Error
        echomsg "Can't find an executor for a command!"
        echohl None
        return
    endif
    try
        if exists("$WSLENV")
            lcd /mnt/c
        endif
        job_start(printf('%s "%s"', runner, cmd))
    catch
        echohl Error
        echomsg v:exception
        echohl None
    finally
        if exists("$WSLENV") | lcd - | endif
        redraw!
    endtry
enddef


# Open filename in an OS
export def Open(url: string)
    var url_x = url
    var cmd = ''
    if executable('cmd.exe')
        cmd = 'cmd.exe /C start ""'
    elseif executable('xdg-open')
        cmd = "xdg-open"
    elseif executable('open')
        cmd = "open"
    else
        echohl Error
        echomsg "Can't find proper opener for an URL!"
        echohl None
        return
    endif
    try
        if exists("$WSLENV")
            lcd /mnt/c
            if filereadable(url)
                url_x = WslToWindowsPath(url)
            endif
        endif
        job_start(printf('%s "%s"', cmd, url_x))
    catch
        echohl Error
        echomsg v:exception
        echohl None
    finally
        if exists("$WSLENV") | lcd - | endif
        redraw!
    endtry
enddef


# Better gx to open URLs.
# nnoremap <silent> gx :call os#Gx()<CR>
export def Gx()
    # URL regexes
    var rx_base = '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S'
    var rx_bare = rx_base .. '\+'
    var rx_embd = rx_base .. '\{-}'

    var URL = ""

    # markdown URL [link text](http://ya.ru 'yandex search')
    var save_view = winsaveview()
    try
        if searchpair('\[.\{-}\](', '', ')\zs', 'cbW', '', line('.')) > 0
            URL = matchstr(getline('.')[col('.') - 1 : ], '\[.\{-}\](\zs' .. rx_embd .. '\ze\(\s\+.\{-}\)\?)')
        endif
    finally
        winrestview(save_view)
    endtry

    # asciidoc URL http://yandex.ru[yandex search]
    if empty(URL)
        save_view = winsaveview()
        try
            if searchpair(rx_bare .. '\[', '', '\]\zs', 'cbW', '', line('.')) > 0
                URL = matchstr(getline('.')[col('.') - 1 : ], '\S\{-}\ze[')
            endif
        finally
            winrestview(save_view)
        endtry
    endif

    # HTML URL <a href='http://www.python.org'>Python is here</a>
    #          <a href="http://www.python.org"/>
    if empty(URL)
        save_view = winsaveview()
        try
            if searchpair('<a\s\+href=', '', '\%(</a>\|/>\)\zs', 'cbW', '', line('.')) > 0
                URL = matchstr(getline('.')[col('.') - 1 : ],
                               'href=["' .. "'" .. ']\?\zs\S\{-}\ze["' .. "'" .. ']\?/\?>')
            endif
        finally
            winrestview(save_view)
        endtry
    endif

    # barebone URL http://google.com
    if empty(URL)
        URL = matchstr(expand("<cfile>"), rx_bare)
    endif

    if empty(URL)
        return
    endif

    Open(escape(URL, '#%!'))
enddef
