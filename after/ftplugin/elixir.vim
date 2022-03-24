vim9script

command -buffer Fmt :up | silent! call system("mix format ", expand("%")) | e

def PopupHelp(symbol: string)
    var cmd = printf('elixir -e "require IEx.Helpers; IEx.Helpers.h(%s)"', symbol)
    popup#ShowAtCursor(systemlist(cmd))
enddef

nnoremap <silent><buffer> K :call <SID>PopupHelp(expand("<cfile>"))<CR>
xnoremap <silent><buffer> K y:call <SID>PopupHelp(@@)<CR>
