vim9script

import autoload 'popup.vim'
import autoload 'os.vim'

var pack_jobs = []

# Update or install plugins listed in packs
export def PackUpdate()
    if !reduce(pack_jobs, (acc, val) => acc && job_status(val) != 'run', true)
        echow "Previous update is not finished yet!"
        return
    endif
    pack_jobs = []
    echow "Update plugins..."
    var cwd = $MYVIMDIR
    var pack_list = $'{cwd}/pack/packs'
    var jobs = []
    var msg_count = 2
    def OutCb(ch: channel, msg: string)
        if msg !~ '.*up to date.$' && msg !~ '^HEAD' && msg !~ '^Removing .*tags' && msg !~ '^Updating files'
            msg_count += 1
            echow msg
        endif
    enddef
    if filereadable(pack_list)
        var plugs = readfile(pack_list)
        for pinfo in plugs
            if pinfo =~ '^\s*#' || pinfo =~ '^\s*$'
                continue
            endif
            var [name, url] = pinfo->split("\t")
            if empty(name) || empty(url)
                continue
            endif
            var path = $"{cwd}/pack/{name}"
            if isdirectory(path)
                var job = job_start([&shell, &shellcmdflag, 'git fetch && git reset --hard @{u} && git clean -dfx'],
                              {"cwd": path, "err_cb": OutCb, "out_cb": OutCb})
                pack_jobs->add(job)
            else
                var job = job_start($'git clone {url} {path}',
                              {"cwd": cwd, "err_cb": OutCb, "out_cb": OutCb})
                pack_jobs->add(job)
            endif
        endfor
    endif
    def TimerHandler(t: number)
        if reduce(pack_jobs, (acc, val) => acc && job_status(val) != 'run', true)
            timer_stop(t)
            if msg_count == 2
                echow "No updates available."
            else
                echow "Plugins are updated!"
            endif
            helptags ALL
        endif
    enddef
    timer_start(2000, (t) => TimerHandler(t), {"repeat": 100})
enddef


# Show commit that introduced current(selected) line
# If a count was given, show full history
# Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
# Usage:
#   import autoload 'git.vim'
#   nnoremap <silent> <space>gi <scriptcmd>git.ShowCommit(v:count)<CR>
#   xnoremap <silent> <space>gi <scriptcmd>git.ShowCommit(v:count, line("v"), line("."))<CR>
export def ShowCommit(count: number, firstline: number = line("."), lastline: number = line("."))
    if !executable('git')
        echoerr "Git is not installed!"
        return
    endif

    var depth = (count > 0 ? "" : "-n 1")
    var git_output = systemlist(
                  "git -C " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
                  $" log --no-merges {depth} -L " ..
                  shellescape($'{firstline},{lastline}:{resolve(expand("%:p"))}')
              )

    popup.ShowAtCursor(git_output, (winid) => {
        setbufvar(winbufnr(winid), "&filetype", "git")
    })
enddef


# Blame current (selected) line.
# Usage:
#   import autoload 'git.vim'
#   nnoremap <silent> <space>gb <scriptcmd>git.Blame()<CR>
#   xnoremap <silent> <space>gb <scriptcmd>git.Blame(line("v"), line("."))<CR>
export def Blame(firstline: number = line("."), lastline: number = line("."))
    if !executable('git')
        echoerr "Git is not installed!"
        return
    endif

    var git_output = systemlist(
                  "git -C " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
                  $' blame -L {firstline},{lastline} {expand("%:t")}')

    popup.ShowAtCursor(git_output, (winid) => {
        setbufvar(winbufnr(winid), "&filetype", "fugitiveblame")
    })
enddef


# Open current line/selection in Github.
# Usage:
#   import autoload 'git.vim'
#   nnoremap <silent> <space>gh <scriptcmd>git.GithubOpen()<CR>
#   xnoremap <silent> <space>gh <scriptcmd>git.GithubOpen(line("v"), line("."))<CR>
export def GithubOpen(firstline: number = line("."), lastline: number = line("."))
    var gitroot = systemlist("git rev-parse --show-toplevel")->join('')
    var filename = strpart(expand('%:p'), len(gitroot) + 1)->tr('\', '/')
    var branch = systemlist("git rev-parse --abbrev-ref HEAD")->join('')
    var remote_url = systemlist("git remote get-url origin")->join('')
    if remote_url =~ '^git@github.com'
        remote_url = remote_url->substitute('^git@github.com:', 'https://github.com/', '')
    endif
    remote_url = remote_url->substitute('.git$', '', '')
    var github_url = $'{remote_url}/blob/{branch}/{filename}#L{firstline}-L{lastline}'
    os.Open(github_url)
enddef
