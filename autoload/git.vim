" Show commit that introduced current line
" Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
" Usage: nnoremap <silent> <Leader>i :call git#show_commit()<CR>
func! git#show_commit()
    if !executable('git')
        echoerr "Git is not installed!"
        return
    endif
    let git_output = systemlist("git log -n 1 -L " . line(".") . ",+1:" . expand("%:p"))
    if !has('nvim')
        let winnr = popup_atcursor(git_output, { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })
        call setbufvar(winbufnr(winnr), "&filetype", "git")
    else
        echoerr "Neovim is not supported!"
    endif
endfunc
