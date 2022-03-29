vim9script

setlocal formatoptions-=cro

# doesn't work on windows for me :(
setlocal formatprg=!mix\ format\ -

command! -buffer Fmt :up | silent! call system("mix format ", expand("%")) | e

def PopupHelp(symbol: string)
    var cmd = printf('elixir -e "require IEx.Helpers; IEx.Helpers.h(%s)"', symbol)
    var winid = popup#ShowAtCursor(systemlist(cmd))
    setbufvar(winbufnr(winid), "&ft", "markdown")
enddef

nnoremap <silent><buffer> K :call <SID>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y:call <SID>PopupHelp(@@)<CR>

nnoremap <silent><buffer> <F5> :botright term ++shell ++close iex -S mix<CR>
