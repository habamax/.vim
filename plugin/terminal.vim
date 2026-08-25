vim9script

import autoload 'terminal.vim'

command! -bang -nargs=? Term terminal.Run(<q-args> ?? &shell, <q-mods> ?? window#BotRight(), expand("<bang>") == "!")

def TermSettings()
    setlocal nonu nornu
    nnoremap <buffer> gq <scriptcmd>bd<CR>
    nnoremap <buffer> <CR> <scriptcmd>terminal.OpenError()<CR>
    nnoremap <buffer> o <scriptcmd>terminal.OpenError(true)<CR>
    nnoremap <buffer> <2-LeftMouse> <scriptcmd>terminal.OpenError(true)<CR>
    nnoremap <buffer> J <scriptcmd>terminal.NextError()<CR>
    nnoremap <buffer> K <scriptcmd>terminal.PrevError()<CR>
    nnoremap <buffer> <C-r> <scriptcmd>terminal.ReRun()<CR>
    nnoremap <buffer> <F5> <scriptcmd>terminal.ReRun()<CR>
enddef

augroup Terminal
    au!
    au TerminalWinOpen * TermSettings()
    au TerminalOpen * ++nested {
        var buf = expand("<afile>")->escape('|#%[ \')
        exe $"au BufWinEnter {buf} ++once TermSettings()"
    }
augroup END
