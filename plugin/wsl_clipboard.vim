vim9script

# Only for WSL
if !exists("$WSLENV")
    finish
endif


# Even if you compile your vim with +clipboard support
# there is no + or * registers available.
# So just yank everything as if clipboard=unnamed
def WSLYank()
    system('clip.exe', getreg("@"))
enddef


def WSLPaste(pasteCmd: string)
    setreg("@", system("powershell.exe -c 'Get-Clipboard'")->substitute('', '', 'g'))
    exe 'normal! ""' .. pasteCmd
enddef


augroup WSLYank | au!
    au TextYankPost * call WSLYank()
augroup END


xnoremap "+p <ScriptCmd>WSLPaste("p")<CR>
xnoremap "+P <ScriptCmd>WSLPaste("P")<CR>
xnoremap "*p <ScriptCmd>WSLPaste("p")<CR>
xnoremap "*P <ScriptCmd>WSLPaste("P")<CR>
nnoremap "+p <ScriptCmd>WSLPaste("p")<CR>
nnoremap "+P <ScriptCmd>WSLPaste("P")<CR>
nnoremap "*p <ScriptCmd>WSLPaste("p")<CR>
nnoremap "*P <ScriptCmd>WSLPaste("P")<CR>

inoremap <C-r>+ <ScriptCmd>WSLPaste("p")<CR><Cmd>normal! `]<CR><Right>
imap <C-r>* <C-r>+
