vim9script

set winaltkeys=no
set guioptions=cM!

set linespace=0
if has("win32")
    set guifont=JetBrains\ Mono\ NL:h15,Consolas:h17
else
    set guifont=Monospace\ 19
endif

# quick font check:
# З3Э -- cyrillic letter З, digit 3, cyrillic letter Э
# 1lI0OQB8 =-+*:(){}[]
# I1legal
