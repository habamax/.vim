vim9script

# assuming + register exists

nnoremap <space>y "+y
xnoremap <space>y "+y

if $XDG_SESSION_TYPE == 'wayland' || (!empty($GVIM_ENABLE_WAYLAND) && has("gui_running"))
    def WLYank(event: dict<any>)
        echom "here"
        if event.regname == '+'
            system('wl-copy', getreg(event.regname))
        endif
    enddef

    def WLPaste()
        setreg("+", systemlist('wl-paste --no-newline')->join("\n"))
    enddef

    augroup WLYank | au!
        au TextYankPost * call WLYank(v:event)
    augroup END

    xnoremap <space>p <ScriptCmd>WLPaste()<CR>"+p
    xnoremap <space>P <ScriptCmd>WLPaste()<CR>"+P
    nnoremap <space>p <ScriptCmd>WLPaste()<CR>"+p
    nnoremap <space>P <ScriptCmd>WLPaste()<CR>"+P
else
    nnoremap <space>p "+p
    nnoremap <space>P "+P
    xnoremap <space>p "+p
    xnoremap <space>P "+P
endif
