vim9script

import autoload 'popup.vim'
import autoload 'text.vim'

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
