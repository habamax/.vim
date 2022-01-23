vim9script


# Return true if vim is in WSL environment
def os#is_wsl(): bool
    return exists("$WSLENV")
enddef


# Return Windows path from WSL
def os#wsl_to_windows_path(path: string): string
    if !os#is_wsl()
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
def os#file_manager()
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

        if os#is_wsl()
            path = escape(os#wsl_to_windows_path(path), '\')
            lcd /mnt/c
            exe 'silent !cmd.exe /s /c start explorer.exe /select,' .. path
            lcd -
            redraw!
        else
            silent exe '!start explorer.exe /select,' .. path
        endif
    else
        echomsg "Not yet implemented!"
    endif
enddef


# Silently execute OS command
def os#exe(cmd: string)
    var runner = ''
    if exists("$WSLENV")
        lcd /mnt/c
        runner = ":silent !cmd.exe /C start"
    elseif executable('cmd.exe')
        runner = ':silent !start'
    elseif executable('xdg-open')
        runner = ":silent !xdg-open"
    elseif executable('open')
        runner = ":silent !open"
    else
        echohl Error
        echomsg "Can't find an executor for a command!"
        echohl None
        return
    endif
    try
        exe runner . ' ' . cmd
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
def os#open(url: string)
    var url_x = url
    var cmd = ''
    if exists("$WSLENV")
        lcd /mnt/c
        cmd = ":silent !cmd.exe /C start"
        if filereadable(url)
            url_x = os#wsl_to_windows_path(url)
        endif
    elseif executable('cmd.exe')
        cmd = ':silent !start'
    elseif executable('xdg-open')
        cmd = ":silent !xdg-open"
    elseif executable('open')
        cmd = ":silent !open"
    else
        echohl Error
        echomsg "Can't find proper opener for an URL!"
        echohl None
        return
    endif
    try
        exe cmd .. ' "' .. url_x .. '"'
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
# nnoremap <silent> gx :call os#gx()<CR>
def os#gx()
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

    os#open(escape(URL, '#%!'))
enddef
