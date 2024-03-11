vim9script

if has("gui_running")
    finish
endif

# cursor shapes
&t_EI = "\e[2 q"
&t_SI = "\e[5 q"
&t_SR = "\e[3 q"
