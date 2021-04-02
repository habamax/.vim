if has("gui_running")
    finish
endif


" Fix vim termguicolors for tmux
" NOTE: your .tmux.conf should have:
"
" set -g default-terminal "screen-256color"
" or
" set -g default-terminal "tmux-256color"
"
" plus
" set -ag terminal-overrides ',xterm-256color:Tc'
if &term =~# '^screen\|tmux' || &term =~# '^xterm-256'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
elseif &term =~# 'win32'
    set t_Co=256
endif


" Fix cursor shapes (insert/replace/normal mode) in WSL bash
if &term =~ "xterm" || &term =~ "tmux"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif
