vim9script

# Quick commands popup

import autoload 'popup.vim'
import autoload 'text.vim'
import autoload 'diff.vim'
import autoload 'git.vim'

# Example of multi level popup
# export def QfLoc()
#     var qf_commands = [
#             {text: "Quickfix"},
#             {text: "Next", key: "j", cmd: "cnext"},
#             {text: "Prev", key: "k", cmd: "cprev"},
#             {text: "Last", key: "J", cmd: "redraw|clast"},
#             {text: "First", key: "K", cmd: "redraw|cfirst"},
#         ]
#     var loc_commands = [
#             {text: "Locations"},
#             {text: "Next", key: ".", cmd: "lnext"},
#             {text: "Prev", key: ",", cmd: "lprev"},
#             {text: "Last", key: ">", cmd: "redraw|llast"},
#             {text: "First", key: "<", cmd: "redraw|lfirst"},
#         ]
#     var commands = [
#         {text: "Quickfix", key: "q", close: true, cmd: () => {
#             popup.Commands(qf_commands)
#         }},
#         {text: "Location", key: "l", close: true, cmd: () => {
#             popup.Commands(loc_commands)
#         }},
#     ]
#     popup.Commands(commands)
# enddef

# Navigate quickfix/location lists, diff.
# Usage:
# import autoload 'qc.vim'
# nnoremap <space>n <scriptcmd>qc.Nav()<CR>
export def Nav()
    var commands: list<dict<any>>
    if &diff
        commands += [
            {text: "Diff", key: "d", close: true, cmd: () => {
                popup.Commands([
                    {text: "Diff"},
                    {text: "Next Chunk", key: "j", cmd: "normal! ]c"},
                    {text: "Previous Chunk", key: "k", cmd: "normal! [c"},
                    {text: "Next Change", key: "J", cmd: () => {
                        diff.NextChange()
                    }},
                    {text: "Previous Change", key: "K", cmd: () => {
                        diff.PrevChange()
                    }},
                    {text: "Put", key: "p", cmd: "normal! dp"},
                    {text: "Obtain", key: "o", cmd: "normal! do"},
                ])
            }}
        ]
    endif
    if len(getqflist()) > 0
        commands += [
            {text: "Quickfix", key: "q", close: true, cmd: () => {
                popup.Commands([
                    {text: "Quickfix"},
                    {text: "Next", key: "j", cmd: "redraw|cnext"},
                    {text: "Prev", key: "k", cmd: "redraw|cprev"},
                    {text: "Last", key: "J", cmd: "redraw|clast"},
                    {text: "First", key: "K", cmd: "redraw|cfirst"},
                ])
            }},
        ]
    endif
    if len(getloclist(winnr())) > 0
        commands += [
            {text: "Locations", key: "l", close: true, cmd: () => {
                popup.Commands([
                    {text: "Locations"},
                    {text: "Next", key: "j", cmd: "redraw|lnext"},
                    {text: "Prev", key: "k", cmd: "redraw|lprev"},
                    {text: "Last", key: "J", cmd: "redraw|llast"},
                    {text: "First", key: "K", cmd: "redraw|lfirst"},
                ])
            }},
        ]
    endif

    if empty(commands)
        return
    endif

    commands->insert({text: "Space Navigation"})
    popup.Commands(commands)
enddef

# horiontal scroll
# Usage:
# import autoload 'qc.vim'
# nnoremap zl <scriptcmd>qc.HScroll($'normal! {v:count1}zl')<CR>
# nnoremap zh <scriptcmd>qc.HScroll($'normal! {v:count1}zh')<CR>
# nnoremap zs <scriptcmd>qc.HScroll($'normal! zs')<CR>
# nnoremap ze <scriptcmd>qc.HScroll($'normal! ze')<CR>
export def HScroll(initial: string)
    exe initial
    var commands = [
        {text: "Horizontal scroll"},
        {text: "Left", key: "h", cmd: "normal! zh"},
        {text: "Right", key: "l", cmd: "normal! zl"},
        {text: "10 x Left", key: "H", cmd: "normal! 10zh"},
        {text: "10 x Right", key: "L", cmd: "normal! 10zl"},
        {text: "Start", key: "s", cmd: "normal! zs"},
        {text: "End", key: "e", cmd: "normal! ze"},
    ]
    popup.Commands(commands)
enddef

# Navigate windows
# Usage:
# import autoload 'qc.vim'
# nnoremap gt <scriptcmd>qc.Windows("gt")<cr>
# nnoremap gT <scriptcmd>qc.Windows("gT")<cr>
# nnoremap <C-w>h <scriptcmd>qc.Windows("h")<cr>
# nmap <C-w><C-h> <C-w>h
# nnoremap <C-w>j <scriptcmd>qc.Windows("j")<cr>
# nmap <C-w><C-j> <C-w>j
# nnoremap <C-w>k <scriptcmd>qc.Windows("k")<cr>
# nmap <C-w><C-k> <C-w>k
# nnoremap <C-w>l <scriptcmd>qc.Windows("l")<cr>
# nmap <C-w><C-l> <C-w>l
export def Windows(initial: string)
    exe "wincmd" initial
    var commands = [
            {text: "Windows"},
            {text: "Left", key: "h", cmd: "wincmd h"},
            {text: "Down", key: "j", cmd: "wincmd j"},
            {text: "Up", key: "k", cmd: "wincmd k"},
            {text: "Right", key: "l", cmd: "wincmd l"},
            {text: "Tabpages"},
            {text: "Next", key: "t", cmd: "wincmd gt"},
            {text: "Prev", key: "T", cmd: "wincmd gT"},
        ]
    popup.Commands(commands)
enddef

# Various text transformations
# Usage:
# import autoload 'qc.vim'
# xnoremap <space>t <scriptcmd>qc.TextTr()<cr>
# nnoremap <space>t <scriptcmd>qc.TextTr()<cr>
export def TextTr()
    if &readonly || !&modifiable
        echo "Cannot modify text in readonly buffer"
        return
    endif
    if mode() == 'n'
        normal! g_v^
    endif
    var region = getregion(getpos('v'), getpos('.'), {type: mode()})
    var base64_commands = [
        {text: "Base64"},
        {text: "Encode", key: "e", close: true, cmd: () => {
            setreg("", region->str2blob()->base64_encode())
            normal! ""p
        }},
        {text: "Decode", key: "d", close: true, cmd: () => {
            # TODO: go line by line?
            setreg("", region->join('')->base64_decode()->blob2str()->join("\n"))
            normal! ""p
        }}
    ]
    var commands = [
        {text: "Text transform"},
        {text: "Fix spaces", key: "s", close: true, cmd: () => {
            text.FixSpaces(line('v'), line('.'))
            exe "normal!" mode()
        }},
        {text: "Base64", key: "b", close: true, cmd: () => {
            popup.Commands(base64_commands, false)
        }},
        {text: "Calc", key: "c", close: true, cmd: () => {
            var result = system($'python -c "from math import *; print({region->join(" ")})"')->trim()
            if v:shell_error == 0
                setreg("", result)
                normal! ""p
            endif
        }},
    ]
    popup.Commands(commands, false)
enddef


# Colorscheme design support: change tgc/256/16/8/0
# Usage:
# import autoload 'qc.vim'
# nnoremap <space>x <scriptcmd>qc.ColorSupport()<CR>
export def ColorSupport()
    var commands = []
    commands->extend([
        {text: "Color support"},
        {text: "tgc/256", key: "g", cmd: () => {
            if &tgc
                set t_Co=256
                set notgc
                popup_notification("Switching to 256 colors", {})
            else
                set t_Co=256
                set tgc
                popup_notification("Switching to GUI colors", {})
            endif
        }},
        {text: "16/8", key: "t", cmd: () => {
            set notgc
            if str2nr(&t_Co) == 16
                set t_Co=8
                popup_notification("Switching to 8 colors", {})
            else
                set t_Co=16
                popup_notification("Switching to 16 colors", {})
            endif
        }},
        {text: "0", key: "T", cmd: () => {
            set notgc
            set t_Co=0
            popup_notification("Switching to 0 colors", {})
        }},
    ])
    popup.Commands(commands)
enddef


# Copilot shortcuts
# Usage:
# import autoload 'qc.vim'
# nnoremap <space>x <scriptcmd>qc.Copilot()<CR>
export def Copilot()
    var commands = []
    commands->extend([
        {text: "Copilot"},
        {text: "Next", key: "n", cmd: () => {
            if exists('*copilot#Next')
                copilot#Next()
            else
                popup_notification("Copilot is not installed", {})
            endif
        }},
        {text: "Prev", key: "p", cmd: () => {
            if exists('*copilot#Previous')
                copilot#Previous()
            else
                popup_notification("Copilot is not installed", {})
            endif
        }},
        {text: "Accept", key: "\<Tab>", cmd: () => {
            if exists('*copilot#Accept')
                feedkeys(copilot#Accept())
            else
                popup_notification("Copilot is not installed", {})
            endif
        }},
        {text: "Accept Line", key: "l", cmd: () => {
            if exists('*copilot#AcceptLine')
                feedkeys(copilot#AcceptLine())
            else
                popup_notification("Copilot is not installed", {})
            endif
        }},
        {text: "Accept Word", key: "w", cmd: () => {
            if exists('*copilot#AcceptWord')
                feedkeys(copilot#AcceptWord())
            else
                popup_notification("Copilot is not installed", {})
            endif
        }},
        {text: "Dismiss", key: "g", close: true, cmd: () => {
            if exists('*copilot#Dismiss')
                feedkeys(copilot#Dismiss())
            else
                popup_notification("Copilot is not installed", {})
            endif
        }},
    ])
    popup.Commands(commands)
enddef

export def Marks()
    var commands: list<dict<any>> = [{text: "Marks"}]
    commands += getmarklist()
        ->extend(getmarklist(bufnr()))
        ->filter((_, v) => v.mark =~ "'\\(\\a\\|['\\[\\]]\\)")
        ->mapnew((_, v) => ({
            key: $"{v.mark[1]}",
            text: get(v, 'file', bufname()) ..  $" ({v.pos[1]})",
            linenr: v.pos[1],
            buffer: get(v, 'file', bufname()),
            close: true,
            cmd: () => {
                exe $"normal! {v.mark}"
            }
        }))
        ->sort((a, b) => {
            if a.buffer == b.buffer
                if a.linenr == b.linenr
                    return 0
                elseif a.linenr > b.linenr
                    return 1
                else
                    return -1
                endif
            elseif a.buffer > b.buffer
                return 1
            else
                return -1
            endif
        })

    var winid = popup.Commands(commands)
    win_execute(winid, 'syn match QCMarkLineNr "(\d\+)$"')
    hi def link QCMarkLineNr NonText
enddef

export def Git()
    def RefreshGitSummary()
        var f_windows = getbufinfo()
            ->filter((_, v) => v.hidden == 0 && v.variables->has_key("fugitive_status"))
            ->mapnew((_, v) => v.windows)->flattennew()
        for w in f_windows
            win_execute(w, ':G')
        endfor
    enddef

    var region = []
    if mode() =~ '[vV]'
        region = [getpos('v'), getpos('.')]
    endif

    var branches = []
    var current_branch = ""

    var cwd = filereadable(expand("%:p:h")) ? expand("%:p:h") : getcwd()
    var gitdir = finddir('.git', cwd .. ";")
    if empty(gitdir)
        echom "Not in a git repository!"
        return
    endif
    var head_file = $"{gitdir}/HEAD"
    var head = readfile(head_file)
    if empty(head)
        echom "Can't read HEAD file!"
        return
    endif
    current_branch = head[0]->substitute('^ref: refs/heads/', '', '')->trim()

    if empty(current_branch)
        echom "Not in a git repository!"
        return
    endif

    for br in readdir($"{gitdir}/refs/heads")
        if br != current_branch
            branches->add(br)
        endif
    endfor

    # TODO: support different forges
    var fetch_head_file = $"{gitdir}/FETCH_HEAD"
    var fetch_head = readfile(fetch_head_file)
    var is_github_remote = false
    if !empty(fetch_head)
        is_github_remote = match(fetch_head[0], 'github\.com') > -1
    endif

    for br in ["dev", "test", "main", "master"]
        var idx = branches->index(br)
        if idx > -1
            branches->remove(idx)
            branches->insert(br)
        endif
    endfor

    var switch_commands: list<dict<any>> = [{text: $'Switch "{current_branch}" to:'}]
    var keys = []
    for v in branches
        var idx = 0
        while idx < len(v)
            # echo keys typename(keys)
            if keys->index(v[idx]) == -1
                keys->add(v[idx])
                break
            endif
            idx += 1
        endwhile
        switch_commands += [{
            key: $"{v[idx]}",
            text: v,
            close: true,
            cmd: $"Git switch {v}"
        }]
    endfor

    var hist_commands: list<dict<any>> = [
        {text: $'Git history of "{current_branch}"'},
        {text: 'last', key: "h", close: true, cmd: () => {
            if empty(region)
                git.ShowCommit(0)
            else
                git.ShowCommit(0, region[0][1], region[1][1])
            endif
        }},
        {text: 'all', key: "a", close: true, cmd: () => {
            if empty(region)
                git.ShowCommit(1)
            else
                git.ShowCommit(1, region[0][1], region[1][1])
            endif
        }}
    ]

    var pull_push_commands: list<dict<any>> = [
        {text: $'Pull/Push "{current_branch}"'},
        {text: $'pull', key: "u", close: true, cmd: () => {
            popup.Sh('git pull', () => {
                RefreshGitSummary()
            })
        }},
        {text: $'push', key: "p", close: true, cmd: () => {
            popup.Sh('git push', () => {
                RefreshGitSummary()
            })
        }},
    ]

    var main_commands: list<dict<any>> = [
        {text: $'Git "{current_branch}"'},
        {text: $'fugitive', key: "g", close: true, "cmd": "Git"},
    ]
    if !empty(branches)
        main_commands += [
            {text: $'switch to ...', key: "s", close: true, cmd: () => {
                popup.Commands(switch_commands)
            }}
        ]
    endif
    main_commands += [
        {text: $'pull/push ...', key: "p", close: true, cmd: () => {
            popup.Commands(pull_push_commands)
        }},
        {text: $'blame', key: "b", close: true, cmd: () => {
            if empty(region)
                git.Blame()
            else
                git.Blame(region[0][1], region[1][1])
            endif
        }},
        {text: $'history ...', key: "h", close: true, cmd: () => {
            popup.Commands(hist_commands)
        }}
    ]
    if is_github_remote
        main_commands += [
            {text: $'open in github', key: "o", close: true, cmd: () => {
                if empty(region)
                    git.GithubOpen()
                else
                    git.GithubOpen(region[0][1], region[1][1])
                endif
            }},
        ]
    endif
    var winid = popup.Commands(main_commands)
enddef
