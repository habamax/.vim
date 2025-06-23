if has("gui_running")
    finish
endif

let &t_EI = "\e[2 q"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
