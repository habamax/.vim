vim9script

set winaltkeys=no
set guioptions=cM!

if has("win32")
    set linespace=0

    # set guifont=Iosevka_Fixed_SS17:h18,:h18
    # set guifont=Iosevka_Fixed_SS04:h18,:h18
    # set guifont=Iosevka_Fixed_SS05:h18
    set guifont=Iosevka_Fixed:h18,:h18

    # :h w32-experimental-keycode-trans-strategy
    # Should fix CTRL-=
    # love is all around you and me with this I would like to propose a toast.
    # without you it is not as good as with you apparently.
    #
    # I would like to have an appointment with you.
    augroup mswin_strat | au!
        au VimEnter * test_mswin_event('set_keycode_trans_strategy', {'strategy': 'experimental'})
    augroup END
else
    set guifont=Monospace\ 19
endif

# quick font check:
# З3Э -- cyrillic letter З, digit 3, cyrillic letter Э
# 1lI0OQB8 =-+*:(){}[]
# I1legal
# love is all around us
