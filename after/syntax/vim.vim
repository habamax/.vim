" fix marks incorrectly highlighted
" :'[,']sort
syn match vimExMarkRange /\(^\|\s\):['`][\[a-zA-Z0-9<][,;]['`][\]a-zA-Z0-9>]/

" clear excessive syntax highlighting
syn clear vimFuncName
syn clear vimVar
syn clear vimOper
syn clear vimOperParen
syn clear vimOperError
syn clear vimUserAttrbError
syn clear vimFunctionError
syn clear vimMenu
syn clear vimMethodName

let s:vim9script = "\n" .. getline(1, 32)->join("\n") =~# '\n\s*vim9\%[script]\>'
if s:vim9script
    syn region vimPreVim9script start="\%^" end="^\s*vim9s\%[cript]\>" contains=@vimLegacyTop,vimComment,vimLineComment keepend
endif
unlet s:vim9script

syn clear vimCommand
syn keyword vimCommand contained vim9cmd vim9script import autoload export def enddef call function endfunction defer defcompile delfunction return
syn keyword vimCommand contained if else elseif endif
syn keyword vimCommand contained for endfor while endwhile continue break
syn keyword vimCommand contained class endclass interface endinterface enum endenum
syn keyword vimCommand contained throw try endtry catch finally
syn keyword vimCommand contained silent unsilent
syn keyword vimCommand contained public static final const var let unlet
syn keyword vimCommand contained highlight runtime source packadd wincmd eval finish verbose command delcommand
