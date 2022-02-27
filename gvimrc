vim9script

set winaltkeys=no
set guioptions=cM

set linespace=0
set guifont=JetBrains\ Mono\ NL:h13

# quick font check:
# З3Э -- буква З, цифра 3, буква Э
# 1lI0OQB8 =-+*:(){}[]

set columns=130
set lines=999

# Auto change background
def Lights()
  if !get(g:, "auto_bg", 1) | return | endif
  if get(g:, "colors_name", "default") != "habamax" | return | endif
  var hour = strftime("%H")->str2nr()
  var bg: string
  if hour > 8 && hour < 17
      bg = "light"
  else
      bg = "dark"
  endif
  if bg != &bg | &bg = bg | endif
enddef

Lights()

if exists("g:lights_timer")
  timer_stop(g:lights_timer)
endif

g:lights_timer = timer_start(5 * 60000, (_) => Lights(), {repeat: -1})


# silent! colorscheme habamax
silent! colorscheme habamaxy
# exe "silent! colorscheme cybermonk" .. ['', 'y']->get(rand() % 2)
