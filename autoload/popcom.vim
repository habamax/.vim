vim9script

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

# Navigate quickfix/location lists.
# Usage:
# import autoload 'popcom.vim'
# nnoremap <space>q <scriptcmd>popcom.Qf()<CR>
export def Qf()
    var commands = []
    if len(getqflist()) > 0
        commands->extend([
            {text: "Quickfix"},
            {text: "Next", key: "j", cmd: "redraw|cnext"},
            {text: "Prev", key: "k", cmd: "redraw|cprev"},
            {text: "Last", key: "J", cmd: "redraw|clast"},
            {text: "First", key: "K", cmd: "redraw|cfirst"},
        ])
    endif
    if len(getloclist(winnr())) > 0
        commands->extend([
            {text: "Locations"},
            {text: "Next", key: ".", cmd: "redraw|lnext"},
            {text: "Prev", key: ",", cmd: "redraw|lprev"},
            {text: "Last", key: ">", cmd: "redraw|llast"},
            {text: "First", key: "<", cmd: "redraw|lfirst"},
        ])
    endif
    popup.Commands(commands)
enddef

# horiontal scroll
# Usage:
# import autoload 'popcom.vim'
# nnoremap zl <scriptcmd>popcom.HScroll($'normal! {v:count1}zl')<CR>
# nnoremap zh <scriptcmd>popcom.HScroll($'normal! {v:count1}zh')<CR>
# nnoremap zs <scriptcmd>popcom.HScroll($'normal! zs')<CR>
# nnoremap ze <scriptcmd>popcom.HScroll($'normal! ze')<CR>
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
# import autoload 'popcom.vim'
# nnoremap gt <scriptcmd>popcom.Windows("gt")<cr>
# nnoremap gT <scriptcmd>popcom.Windows("gT")<cr>
# nnoremap <C-w>h <scriptcmd>popcom.Windows("h")<cr>
# nmap <C-w><C-h> <C-w>h
# nnoremap <C-w>j <scriptcmd>popcom.Windows("j")<cr>
# nmap <C-w><C-j> <C-w>j
# nnoremap <C-w>k <scriptcmd>popcom.Windows("k")<cr>
# nmap <C-w><C-k> <C-w>k
# nnoremap <C-w>l <scriptcmd>popcom.Windows("l")<cr>
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
# import autoload 'popcom.vim'
# xnoremap <space>t <scriptcmd>popcom.TextTr()<cr>
# nnoremap <space>t <scriptcmd>popcom.TextTr()<cr>
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
# import autoload 'popcom.vim'
# nnoremap <space>x <scriptcmd>popcom.ColorSupport()<CR>
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
# import autoload 'popcom.vim'
# nnoremap <space>x <scriptcmd>popcom.Copilot()<CR>
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


# Diff shortcuts
# Usage:
# import autoload 'popcom.vim'
# nnoremap <space>gd <scriptcmd>popcom.Diff()<CR>
export def Diff()
    if !&diff
        echo "Diff mode is not enabled!"
        return
    endif
    var commands = [
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
    ]
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
    win_execute(winid, 'syn match PopComMarkLineNr "(\d\+)$"')
    hi def link PopComMarkLineNr NonText
enddef

export def Git()
    var region = []
    if mode() =~ '[vV]'
        region = [getpos('v'), getpos('.')]
    endif

    var branches = []
    var current_branch = ""
    systemlist('git branch')
        ->mapnew((_, v) => v->trim())
        ->foreach((_, v) => {
            if v[0] == '*'
                current_branch = v[2 : ]
            else
                branches->add(v)
            endif
        })

    if empty(current_branch)
        echom "Not in a git repository!"
        return
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
            cmd: $"Git checkout {v}"
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
        {text: $'blame', key: "b", close: true, cmd: () => {
            if empty(region)
                git.Blame()
            else
                git.Blame(region[0][1], region[1][1])
            endif
        }},
        {text: $'history ...', key: "h", close: true, cmd: () => {
            popup.Commands(hist_commands)
        }},
        {text: $'open in github', key: "o", close: true, cmd: () => {
            if empty(region)
                git.GithubOpen()
            else
                git.GithubOpen(region[0][1], region[1][1])
            endif
        }},
    ]
    var winid = popup.Commands(main_commands)
enddef
