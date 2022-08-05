vim9script

set winaltkeys=no
set guioptions=cM

set guicursor=n-c-v:block-Cursor/lCursor-blinkon0
set guicursor+=i-ci:ver25-Cursor/lCursor-blinkon0
set guicursor+=o:hor50-Cursor/lCursor-blinkon0
set guicursor+=r-cr:hor20-Cursor/lCursor-blinkon0
set guicursor+=sm:block-Cursor-blinkon0


set linespace=0
if has("win32")
    # set guifont=JetBrains\ Mono\ NL:h15,Consolas:h15
    set guifont=Cascadia\ Mono:h14,Consolas:h15
else
    set guifont=Monospace\ 15
endif

# quick font check:
# З3Э -- буква З, цифра 3, буква Э
# 1lI0OQB8 =-+*:(){}[]
