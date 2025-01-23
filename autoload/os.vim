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

    var res = systemlist($"wslpath -w '{path}'")
    return empty(res) ? path : res[0]
enddef


# Open explorer/nautilus/dolphin with current file selected (if possible).
export def FileManager()
    var path = ''
    if expand("%:p") == ""
        path = expand("%:p:h")
    else
        path = expand("%:p")
    endif
    path = substitute(path, "^dir://", "", "")
    var select = isdirectory(path) ? "" : "--select"

    if executable("cmd.exe")
        var job_opts = {}
        if IsWsl()
            path = escape(WslToWindowsPath(path), '\')
            job_opts.cwd = "/mnt/c"
        endif
        job_start('cmd.exe /c start "" explorer.exe /select,' .. path, job_opts)
    elseif executable("dolphin")
        system($'dolphin {select} {path} &')
    elseif executable("nautilus")
        job_start($'nautilus {select} {path}')
    else
        echomsg "Not yet implemented!"
    endif
enddef


# Silently execute OS command
export def Exe(cmd: string)
    var job_opts = {}
    if exists("$WSLENV")
        job_opts.cwd = "/mnt/c"
    endif
    job_start(cmd, job_opts)
enddef


# Silently execute OS command
export def ExeTerm(cmd: string)
    var job_opts = {term_finish: "close", term_rows: 15}
    if exists("$WSLENV")
        job_opts.cwd = "/mnt/c"
    endif
    botright term_start(cmd, job_opts)
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
    var job_opts = {}
    if exists("$WSLENV")
        job_opts.cwd = "/mnt/c"
        if filereadable(url)
            url_x = WslToWindowsPath(url)->escape('\\')
        endif
    endif
    if $DESKTOP_SESSION =~ 'plasma\(wayland\)\?'
        system(printf('%s "%s" &', cmd, url_x))
    else
        job_start(printf('%s "%s"', cmd, url_x), job_opts)
    endif
enddef


# Better gx to open URLs. https://ya.ru
# nnoremap <silent> gx :call os#Gx()<CR>
export def Gx()
    # URL regexes
    var rx_base = '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S'
    var rx_bare = rx_base .. '\+'
    var rx_embd = rx_base .. '\{-}'

    var URL = ""

    # markdown URL [link text](http://ya.ru 'yandex search')
    var save_view = winsaveview()
    defer winrestview(save_view)
    if searchpair('\[.\{-}\](', '', ')\zs', 'cbW', '', line('.')) > 0
        URL = matchstr(getline('.')[col('.') - 1 : ], '\[.\{-}\](\zs' .. rx_embd .. '\ze\(\s\+.\{-}\)\?)')
    endif

    # asciidoc URL http://yandex.ru[yandex search]
    if empty(URL)
        if searchpair(rx_bare .. '\[', '', '\]\zs', 'cbW', '', line('.')) > 0
            URL = matchstr(getline('.')[col('.') - 1 : ], '\S\{-}\ze[')
        endif
    endif

    # HTML URL <a href='http://www.python.org'>Python is here</a>
    #          <a href="http://www.python.org"/>
    if empty(URL)
        if searchpair('<a\s\+href=', '', '\%(</a>\|/>\)\zs', 'cbW', '', line('.')) > 0
            URL = matchstr(getline('.')[col('.') - 1 : ],
                'href=["' .. "'" .. ']\?\zs\S\{-}\ze["' .. "'" .. ']\?/\?>')
        endif
    endif

    # URL <http://google.com>
    if empty(URL)
        URL = matchstr(expand("<cWORD>"), $'^<\zs{rx_bare}\ze>$')
    endif

    # URL (http://google.com)
    if empty(URL)
        URL = matchstr(expand("<cWORD>"), $'^(\zs{rx_bare}\ze)$')
    endif

    # barebone URL http://google.com
    if empty(URL)
        URL = matchstr(expand("<cWORD>"), rx_bare)
    endif

    if empty(URL)
        return
    endif

    Open(escape(URL, '#%!'))
enddef
