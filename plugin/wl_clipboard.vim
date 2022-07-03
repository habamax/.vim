vim9script


if $TERM != 'foot'
    finish
endif


def WLYank(event: dict<any>)
    if event.regname =~ '+' || &clipboard =~ '\<unnamed\(plus\)\?\>'
        system('wl-copy', getreg("@"))
    endif
enddef


def WLPaste(pasteCmd: string)
    setreg("@", system('wl-paste --no-newline')->substitute('', '', 'g'))
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
