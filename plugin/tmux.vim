vim9script

# Add and uncomment following lines to your .tmux.conf:
# bind -n M-h if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-h" "select-pane -L"
# bind -n M-j if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-j" "select-pane -D"
# bind -n M-k if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-k" "select-pane -U"
# bind -n M-l if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys M-l" "select-pane -R"

if !has("gui_running")
    set <M-h>=h
    set <M-j>=j
    set <M-k>=k
    set <M-l>=l
endif

if empty($TMUX)
    noremap <M-h> <scriptcmd>wincmd h<CR>
    noremap <M-j> <scriptcmd>wincmd j<CR>
    noremap <M-k> <scriptcmd>wincmd k<CR>
    noremap <M-l> <scriptcmd>wincmd l<CR>
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

noremap <M-h> <scriptcmd>TmuxVimNavigate("h")<CR>
noremap <M-j> <scriptcmd>TmuxVimNavigate("j")<CR>
noremap <M-k> <scriptcmd>TmuxVimNavigate("k")<CR>
noremap <M-l> <scriptcmd>TmuxVimNavigate("l")<CR>
