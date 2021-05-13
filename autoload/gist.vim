" Author: Maxim Kim <habamax@gmail.com>
" Desc: Sync current buffer with the github gist having the same file name.
"
" Prereqs:
" 1. Install and setup https://cli.github.com/
" 2. Put this file to ~/.vim/autoload/gist.vim
"
" Usage: Open file and :call gist#sync()
"
" Create helper command if needed
" command! GistSync call gist#sync()


func! gist#sync() abort
    if empty(bufname())
        echohl Error
        echomsg "Can't sync empty buffer!"
        echohl None
        return
    elseif empty(get(b:, 'gist_repo', '')) && !s:gist_init()
        echohl Error
        echomsg "Can't sync '" .. expand("%:t") .. "' gist!"
        echohl None
        return
    endif

    try
        exe printf('%write! %s/%s', b:gist_repo, expand('%:t'))
        let cwd = getcwd()
        exe 'lcd ' .. b:gist_repo
        call system("git add -A && git diff-index --quiet HEAD || git commit -m 'vim-update' && git push")
        if v:shell_error
            echohl Error
            echomsg "Can't sync '" .. expand("%:t") .. "' gist. Error code: " .. v:shell_error
            echohl None
            return
        else
            echomsg "Gist '" .. expand("%:t") .. "' is updated."
        endif
    finally
        exe 'lcd ' .. cwd
    endtry
endfunc


func! s:gist_init() abort
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
            echohl None
            return v:false
        else
            let gist_id = s:gist_get_id()
        endif
        if exists("b:gist_repo")
            unlet b:gist_repo
        endif
    endif

    if !empty(gist_id) && empty(get(b:, 'gist_repo', ''))
        return s:gist_clone(gist_id)
    endif

    return v:true
endfunc


func! s:gist_clone(id) abort
    let gist_repo = tempname()
    call system(printf('gh gist clone %s %s', a:id, gist_repo))
    if v:shell_error
        echohl Error
        echomsg "Can't edit '" .. expand("%:t") .. "' as a gist... Error code: " .. v:shell_error
        echohl None
        return v:false
    else
        let b:gist_repo = gist_repo
        return v:true
    endif
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
