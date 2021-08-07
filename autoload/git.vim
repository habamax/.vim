" Update or install plugins listed in packages
func! git#pack_update() abort
    if !reduce(get(s:, 'pack_jobs', []), {acc, val -> acc && job_status(val) != 'run'}, v:true)
        echo "Previous update is not finished yet!"
        return
    endif
    let s:pack_jobs = []
    echom "Update packages..."
    let cwd = fnamemodify($MYVIMRC, ":p:h")
    let bundle = 'plug'
    let pack_list = 'pack/packages'
    let jobs = []
    let msg_count = 2
    func! s:out_cb(ch, msg) abort closure
        if a:msg !~ '.*up to date.$'
            let msg_count += 1
            echom a:msg
        endif
    endfunc
    if filereadable(cwd ..pack_list)
        let packages = readfile(cwd .. pack_list)
        for pinfo in packages
            if pinfo =~ '^\s*#' || pinfo =~ '^\s*$'
                continue
            endif
            let [name, url] = pinfo->split()
            if empty(name) || empty(url)
                continue
            endif
            let path = cwd .. '/pack/'..bundle..'/' .. name
            if isdirectory(path)
                let job = job_start('git pull --depth=1', 
                            \ {"cwd": path,
                            \  "err_cb": function("s:out_cb"),
                            \  "out_cb": function("s:out_cb")})
                call add(s:pack_jobs, job)
            else
                let job = job_start('git clone --depth=1 ' .. url .. ' ' .. path,
                            \ {"cwd": path,
                            \  "err_cb": function("s:out_cb"),
                            \  "out_cb": function("s:out_cb")})
                call add(s:pack_jobs, job)
            endif
        endfor
    endif
    func! s:timer_handler(t) abort closure
        if reduce(get(s:, 'pack_jobs', []), {acc, val -> acc && job_status(val) != 'run'}, v:true)
            call timer_stop(a:t)
            if msg_count == 2
                echom "No updates available."
            else
                echom "Packages are updated!"
            endif
            call feedkeys(":"..msg_count.."messages\<CR>", 'n')
        endif
    endfunc
    call timer_start(2000, {t->s:timer_handler(t)}, {"repeat": 10})
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
