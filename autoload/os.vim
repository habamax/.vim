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
