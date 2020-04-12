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
        endif

        " exec 'silent !cmd.exe /c start explorer.exe /select,"' . path . '"'
        " silent exec '!start explorer.exe /select,"' . path . '"'

        let cmd = 'cmd.exe /c explorer.exe /select,"' . path . '"'
        if exists("*job_start")
            call job_start(cmd)
        elseif exists("*jobstart")
            call jobstart(cmd)
        endif

    endif
endfunc


"" Open URL under cursor using OS
"" http://ya.ru
"" ~/docs
"" $HOME/docs
"" C:/Users/maksim.kim/docs
"" .
func! os#open_url(word) abort
    " Windows only for now
    if !has("win32")
        return
    endif
    let word = a:word
    if word =~ '^[~.$].*'
        let word = expand(word)
    endif
    " TODO: check if barebone url
    " TODO: check if path or a filename
    " TODO: check and extract asciidoctor url
    " TODO: check and extract markdown url
    exe printf("silent !start %s", word)
    " nnoremap gx :call job_start('cmd.exe /c start '.expand("<cfile>"))<CR>
endfunc


