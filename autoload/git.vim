" Show commit that introduced current line
" Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
" Usage: noremap <silent> <Leader>i :call git#show_commit()<CR>
" Note: should be in .vim/autoload/git.vim
func! git#show_commit() range
    if !executable('git')
        echoerr "Git is not installed!"
        return
    endif
    if has('nvim')
        echoerr "Neovim is not supported!"
        return
    endif

    let git_output = systemlist(
                \ "cd " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
                \ " && " ..
                \ "git log --no-merges -n 1 -L " ..
                \ shellescape(a:firstline . "," . a:lastline . ":" . resolve(expand("%:p")))
                \ )

    let winnr = popup_atcursor(git_output, { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })
    call setbufvar(winbufnr(winnr), "&filetype", "git")
endfunc
