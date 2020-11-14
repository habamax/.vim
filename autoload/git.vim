"" Show commit that introduced current(selected) line
"" If a count was given, show full history
"" Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
"" Usage: noremap <silent> <Leader>i :call git#show_commit(v:count)<CR>
"" Note: should be in .vim/autoload/git.vim
func! git#show_commit(count) range
    if !executable('git')
        echoerr "Git is not installed!"
        return
    endif

    let depth = (a:count > 0 ? "" : "-n 1")
    let git_output = systemlist(
                \ "git -C " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
                \ " log --no-merges " .. depth .. " -L " ..
                \ shellescape(a:firstline .. "," . a:lastline .. ":" .. resolve(expand("%:p")))
                \ )

    let winnr = popup_atcursor(git_output, { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })
    call setbufvar(winbufnr(winnr), "&filetype", "git")
endfunc


"" Blame current (selected) line.
"" Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
"" Usage: noremap <silent> <Leader>i :call git#show_commit()<CR>
"" Note: should be in .vim/autoload/git.vim
func! git#blame() range
    if !executable('git')
        echoerr "Git is not installed!"
        return
    endif

    let git_output = systemlist(
                \ "git -C " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
                \ " blame -L " ..
                \ a:firstline .. "," . a:lastline .. " " .. expand("%:t")
                \ )

    let winnr = popup_atcursor(git_output, { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })
    call setbufvar(winbufnr(winnr), "&filetype", "git")
endfunc
