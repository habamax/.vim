vim9script

set winaltkeys=no
set guioptions=cM!

set linespace=0

if has("win32")
    set guifont=Cascadia\ Mono\ SemiLight:h14,:h17

    # :h w32-experimental-keycode-trans-strategy
    # Should fix CTRL-=
    augroup mswin_strat | au!
        au VimEnter * test_mswin_event('set_keycode_trans_strategy', {'strategy': 'experimental'})
    augroup END
else
    set guifont=Monospace\ 21
endif

# quick font check:
# З3Э -- cyrillic letter З, digit 3, cyrillic letter Э
# 1lI0OQB8 =-+*:(){}[]
# I1legal
