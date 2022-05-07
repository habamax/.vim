vim9script

set winaltkeys=no
set guioptions=cM

set linespace=0
if has("win32")
    # set guifont=JetBrains\ Mono\ NL:h13,Consolas:h13
    set guifont=Iosevka\ Term\ SS16:h13,Consolas:h13
    # set guifont=Iosevka\ Term\ SS16\ extended:h13,Consolas:h13
else
    set guifont=JetBrains\ Mono\ NL\ 13,Monospace\ 13
endif

# quick font check:
# З3Э -- буква З, цифра 3, буква Э
# 1lI0OQB8 =-+*:(){}[]
