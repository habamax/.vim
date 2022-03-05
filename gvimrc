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

exe "silent! colorscheme "
      \ .. ["habamax", "cybermonk"]->get(rand() % 2)
      \ .. ['', 'y']->get(rand() % 2)
