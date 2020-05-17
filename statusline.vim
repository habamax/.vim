set laststatus=2
" set ruler " for default statusline"

let s:sep = '┊'


func! StatusMod()
    if &modified
        return "*"
    endif
    return ''
endfunc


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


set statusline=%f
set statusline+=%{StatusMod()}
set statusline+=%<
set statusline+=%=
set statusline+=%{StatusRight()}
set statusline+=%5(%p%%%)
