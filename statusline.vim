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

if get(g:, "status_bright_winnr", v:false)
    set statusline=%#StatusLine#%(%{misc#unicode_number(winnr())}%)%*
else
    set statusline=%(%{misc#unicode_number(winnr())}%)
endif
set statusline+=%([\%R%M]%)
set statusline+=%<%f
set statusline+=%=
set statusline+=%(\ %y%)
set statusline+=%(%{StatusGitBranch()}%)
set statusline+=%3v#%4(%p%%%)
