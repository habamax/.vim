"" Author: Maxim Kim <habamax@gmail.com>
"" Usage:
"" 1. install and setup github-cli tools
"" 2. open a file you want to create gist from
"" 3. call gist#edit()
"" 4. edit file
"" 5. call gist#update()
""
"" Create helper commands if needed
"" command! GistEdit call gist#edit()
"" command! GistUpdate call gist#update()


func! gist#edit() abort
    let gist_id = s:gist_get_id()
    if empty(gist_id)
        echomsg "Gist '" .. expand("%:t") .. "' doesn't exist, creating..."
        try
            let cwd = getcwd()
            lcd %:p:h
            call system('gh gist create -p ' .. shellescape(expand("%:t")))
        finally
            exe 'lcd ' .. cwd
        endtry
        if v:shell_error
            echohl Error
            echomsg "Can't create '" .. expand("%:t") .. "' as a gist... Error code: " .. v:shell_error
            echohl Normal
            return
        else
            let gist_id = s:gist_get_id()
        endif
        if exists("b:gist_repo")
            unlet b:gist_repo
        endif
    endif

    if !empty(gist_id) && empty(get(b:, 'gist_repo', ''))
        call s:gist_clone(gist_id)
    elseif !empty(gist_id)
        echomsg ":GistUpdate when finish editing gist."
    endif
endfunc


func! gist#update() abort
    if empty(get(b:, 'gist_repo', ''))
        echomsg "Edit gist first!"
        return
    endif

    try
        exe printf('%write! %s/%s', b:gist_repo, expand('%:t'))
        let cwd = getcwd()
        exe 'lcd ' .. b:gist_repo
        call system("git add -A && git diff-index --quiet HEAD || git commit -m 'vim-update' && git push")
        if v:shell_error
            echohl Error
            echomsg "Can't update '" .. expand("%:t") .. "' gist. Error code: " .. v:shell_error
            echohl Normal
            return
        else
            echomsg "Gist '" .. expand("%:t") .. "' is updated."
        endif
    finally
        exe 'lcd ' .. cwd
    endtry
endfunc


func! s:gist_info(gist) abort
    let gist = a:gist->split('\t')
    return [gist[0], gist[1]]
endfunc


func! s:gist_get_id() abort
    let gists = systemlist('gh gist list')->map({idx, val -> s:gist_info(val)})
    let idx = gists->copy()->map({idx, val -> val[1]})->index(expand('%:t'))
    if idx >= 0
        return gists[idx][0]
    else
        return ''
    endif
endfunc


func! s:gist_clone(id) abort
    let gist_repo = tempname()
    call system(printf('gh gist clone %s %s', a:id, gist_repo))
    if v:shell_error
        echohl Error
        echomsg "Can't edit '" .. expand("%:t") .. "' as a gist... Error code: " .. v:shell_error
        echohl Normal
    else
        let b:gist_repo = gist_repo
        echomsg ":GistUpdate when finish editing gist."
    endif
endfunc
