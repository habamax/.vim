vim9script

# Add following to your .tmux.conf (uncommented):
# bind -n M-k if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-k" "select-pane -U"
# bind -n M-j if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-j" "select-pane -D"
# bind -n M-h if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-h" "select-pane -L"
# bind -n M-l if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-l" "select-pane -R"

if empty($TMUX)
    finish
endif

var tmuxSocket = split($TMUX, ',')[0]

def TmuxCommand(cmd: string): string
    return trim(system($"tmux -S {tmuxSocket} {cmd}"))
enddef

def TmuxVimNavigate(direction: string)
    var winnr = winnr()
    exe "wincmd" direction
    if winnr == winnr() && TmuxCommand("display-message -p '#{window_zoomed_flag}'") != "1"
        TmuxCommand($'select-pane -{tr(direction, "hjkl", "LDUR")}')
    endif
enddef

set <M-h>=h
set <M-j>=j
set <M-k>=k
set <M-l>=l
nnoremap <M-h> <scriptcmd>TmuxVimNavigate("h")<CR>
nnoremap <M-j> <scriptcmd>TmuxVimNavigate("j")<CR>
nnoremap <M-k> <scriptcmd>TmuxVimNavigate("k")<CR>
nnoremap <M-l> <scriptcmd>TmuxVimNavigate("l")<CR>
