vim9script


if $TERM != 'foot'
    finish
endif

# 24 bit color support
set t_8f=[38:2::%lu:%lu:%lum
set t_8b=[48:2::%lu:%lu:%lum

def WLYank(event: dict<any>)
    if event.regname =~ '+' || &clipboard =~ '\<unnamed\(plus\)\?\>'
        system('wl-copy', getreg("@"))
    endif
enddef


def WLPaste(pasteCmd: string)
    setreg("@", system('wl-paste --no-newline')->substitute('
    exe 'normal! ""' .. pasteCmd
enddef


augroup WLYank | au!
    au TextYankPost * call WLYank(v:event)
augroup END


if &clipboard =~ '\<unnamed\(plus\)\?\>'
    xnoremap p <ScriptCmd>WLPaste("p")<CR>
    xnoremap P <ScriptCmd>WLPaste("P")<CR>
    nnoremap p <ScriptCmd>WLPaste("p")<CR>
    nnoremap P <ScriptCmd>WLPaste("P")<CR>
endif

xnoremap "+p <ScriptCmd>WLPaste("p")<CR>
xnoremap "+P <ScriptCmd>WLPaste("P")<CR>
xnoremap "*p <ScriptCmd>WLPaste("p")<CR>
xnoremap "*P <ScriptCmd>WLPaste("P")<CR>
nnoremap "+p <ScriptCmd>WLPaste("p")<CR>
nnoremap "+P <ScriptCmd>WLPaste("P")<CR>
nnoremap "*p <ScriptCmd>WLPaste("p")<CR>
nnoremap "*P <ScriptCmd>WLPaste("P")<CR>

inoremap <C-r>+ <ScriptCmd>WLPaste("p")<CR><Cmd>normal! `]<CR><Right>
imap <C-r>* <C-r>+