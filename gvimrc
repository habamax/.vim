vim9script

set winaltkeys=no
set guioptions=CcM!

if has("win32")
    set renderoptions=type:directx

    set linespace=0
    set guifont=Iosevka_Habamax:h17,:h17

    # :h w32-experimental-keycode-trans-strategy
    # Should fix CTRL-=
    augroup mswin_strat | au!
        au VimEnter * test_mswin_event('set_keycode_trans_strategy', {'strategy': 'experimental'})
    augroup END

    command! ToggleFullscreen {
        if &guioptions =~# 's'
            set guioptions-=s
        else
            set guioptions+=s
        endif
    }
    nnoremap <F11> <cmd>ToggleFullscreen<CR>
else
    set guifont=Monospace\ 17
endif

# quick font check:
# З3Э -- cyrillic ze, three, cyrillic e
# 1lI0OQB8 =-+*:(){}[]
# I1legal
