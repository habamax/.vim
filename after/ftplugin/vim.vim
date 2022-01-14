vim9script

setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

def StripSyntax()
    hi link vimVar Normal
    hi link vimOper Normal
    hi link vimParenSep Normal
    hi link vimSep Normal
enddef

StripSyntax()

augroup strip_vim_syntax | au!
    au ColorScheme * call StripSyntax()
augroup END
