set laststatus=2
" set ruler " for default statusline"

let s:sep = '┊'


func! StatusRight()
    let right = s:sep

    if &iminsert == 0
        let right .= ' EN '.s:sep
    else
        let right .= ' RU '.s:sep
    endif

    if &readonly
        let right .= ' RO '.s:sep
    endif

    if &ft != ''
        let right .= printf(" %s %s", &ft, s:sep)
    endif

    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        if !empty(branch)
            let right .= printf(" git:%s %s", branch, s:sep)
        endif
    endif

    return right
endfunc


func! SetStatusline(active) abort
    if a:active
        setlocal statusline=%f
        setlocal statusline+=%{&mod?'*':''}
        setlocal statusline+=%<
        setlocal statusline+=%=
        setlocal statusline+=%{StatusRight()}
        setlocal statusline+=%4(%p%%%)
    else
        setlocal statusline=%f
    endif
endfunc


augroup statusline | au!
    au BufEnter,WinEnter * :call SetStatusline(v:true)
    au BufLeave,WinLeave * :call SetStatusline(v:false)
augroup end
