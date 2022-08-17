vim9script

setlocal formatoptions-=cro

# doesn't work on windows for me :(
setlocal formatprg=!mix\ format\ -

command! -buffer Fmt :up | silent! call system("mix format ", expand("%")) | e

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    var cmd = $'elixir -e "require IEx.Helpers; IEx.Helpers.h({symbol})"'
    var winid = popup.ShowAtCursor(systemlist(cmd))
    setbufvar(winbufnr(winid), "&ft", "markdown")
enddef

nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>

nnoremap <silent><buffer> <F5> :botright term ++shell ++close iex -S mix<CR>
