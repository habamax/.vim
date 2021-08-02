" Packages as git submodules
" On a new machine:
" git clone git:github.com:habamax/.vim ~/.vim
" git submodule update --init
func! git#pack_add(name, opt = v:false) abort
    try
        exe "lcd! " .. fnamemodify($MYVIMRC, ":p:h")
        let cmd = 'git submodule add git@github.com:' .. a:name .. '.git ./pack/github/'
        let cmd .= a:opt ? 'opt/' : 'start/'
        let cmd .= split(a:name, '/')[1]
        echo system(cmd)
    finally
        lcd! -
    endtry
endfunc

func! git#pack_update() abort
    try
        exe "lcd! " .. fnamemodify($MYVIMRC, ":p:h")
        if exists(":Git")
            :Git submodule update --init --remote --rebase --no-fetch --jobs=10
        else
            echo system('git submodule update --init --remote --rebase --no-fetch --jobs=10')
        endif
        echo "Packages were updated."
    finally
        lcd! -
    endtry
endfunc


" Show commit that introduced current(selected) line
" If a count was given, show full history
" Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
" Usage: noremap <silent> <Leader>gi :call git#show_commit(v:count)<CR>
" Note: should be in .vim/autoload/git.vim
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


" Blame current (selected) line.
" Usage: noremap <silent> <Leader>gb :call git#blame()<CR>
" Note: should be in .vim/autoload/git.vim
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
