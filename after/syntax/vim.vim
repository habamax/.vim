" clear excessive syntax highlighting
syn clear vimFuncName
syn clear vimVar
syn clear vimOper
syn clear vimOperError
syn clear vimFunctionError
syn clear vimMenu
syn clear vimCommand
syn clear vimUserCmdAttrError
syn keyword vimCommand contained vim9cmd vim9script import autoload export def enddef call function endfunction defer defcompile delfunction return
syn keyword vimCommand contained if else elseif endif
syn keyword vimCommand contained for endfor while endwhile continue break
syn keyword vimCommand contained class endclass interface endinterface enum endenum
syn keyword vimCommand contained throw try endtry catch finally
syn keyword vimCommand contained silent unsilent
syn keyword vimCommand contained public static final const var let unlet
syn keyword vimCommand contained highlight runtime source packadd wincmd eval finish verbose command delcommand
