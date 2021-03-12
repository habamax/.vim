if has("gui_running") || has('nvim') 
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

" Fix vim cursor shape in tmux
" if exists("$TMUX")
"     let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
"     let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
" endif

" to fix cursor shape in WSL bash add
" echo -ne "\e[2 q"
" to .bashrc
if &term =~ "xterm" || &term =~ "tmux"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif


" Fix Alt mappings for terminal vim
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
if !has('win32')
    let c='a'
    while c <= 'z'
        exec "set <A-".c.">=\e".c
        exec "map \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
    let c='0'
    while c <= '9'
        exec "set <A-".c.">=\e".c
        exec "map \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
endif
