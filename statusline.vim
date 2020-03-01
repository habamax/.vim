func! StatusGitBranch()
    let branch = ''
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        if !empty(branch)
            let branch = printf("[%s]", branch)
        endif
    endif
    return branch
endfunc

set laststatus=2
" set ruler " for default statusline"

set statusline=%([\%R%M]%)
set statusline+=%<%f
set statusline+=%=
set statusline+=%(\ %y%)
set statusline+=%(%{StatusGitBranch()}%)
set statusline+=%3c#%4(%p%%%)
