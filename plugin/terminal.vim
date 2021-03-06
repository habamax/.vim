if has("gui_running")
    finish
endif


" Fix vim termguicolors for tmux
" NOTE: your .tmux.conf should have:
"
" set -g default-terminal "tmux-256color"
" set -ag terminal-overrides ',*:RGB'
if &term =~# '^screen\|tmux' || &term =~# '^xterm-256'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
elseif &term =~# 'win32'
    set t_Co=256
endif


" Fix cursor shapes (insert/replace/normal mode)
if &term =~# 'xterm\|tmux\|win32'
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif
