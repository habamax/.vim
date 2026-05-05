if has("gui_running")
    finish
endif

" Cursor shapes
let &t_EI = "\e[2 q"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"

" Undercurl in Windows Terminal
if !empty($WT_SESSION)
    let &t_Cs = "\e[4:3m"
endif
