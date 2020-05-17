set laststatus=2
" let g:status_bright_winnr = 1
" set ruler " for default statusline"


func! StatusIM() abort
    if &iminsert == 0
        return '  EN |'
    else
        return '  RU |'
    endif
endfunc


func! StatusGitBranch()
    let branch = ''
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        if !empty(branch)
            let branch = printf("  git:%s", branch)
        endif
    endif
    return branch
endfunc


func! StatusFT()
    if &ft != ''
        return printf("  %s |", &ft)
    endif
    return ''
endfunc


func! StatusMod()
    if &modified
        return "+ "
    endif
    return ''
endfunc


func! StatusMisc()
    let misc = ''
    if &readonly
        let misc .= "  RO |"
    endif
    return misc
endfunc


set statusline=%{StatusMod()}
set statusline+=%f%<
set statusline+=%=
set statusline+=%{StatusIM()}
set statusline+=%{StatusMisc()}
set statusline+=%{StatusFT()}
set statusline+=%{StatusGitBranch()}
set statusline+=%5(%p%%%)
