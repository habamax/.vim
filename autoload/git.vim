vim9script

import autoload 'popup.vim'
import autoload 'os.vim'

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
