vim9script

if exists("b:current_syntax")
    finish
endif

syn match shellcmdCmd "\%^.*$" contains=shellcmdCmdPrompt
syn match shellcmdCmdPrompt "^\$" contained
syn match shellcmdExitCodeErr "^Exit code: .*\%$"
syn match shellcmdExitCodeNoErr "^Exit code: 0\%$"

syn match shellcmdCargoPath "-->\s\+.\{-}:\d\+:\d\+" contains=shellcmdCargoPathNr
syn match shellcmdCargoPathNr ":\d\+:\d\+" contained

syn match shellcmdGrepPath "^\S.\{-}\S:\(\d\+:\)\{1,2}" contains=shellcmdGrepPathNr
syn match shellcmdGrepPathNr ":\(\d\+:\)\{1,2}" contained

syn match shellcmdPythonLocation '^\s\+File ".\{-}", line \d\+' contains=shellcmdPythonPath,shellcmdPythonNr
syn match shellcmdPythonPath 'File "\zs.\{-}\ze"' contained
syn match shellcmdPythonNr "line \zs\d\+" contained

syn match shellcmdError "\c^\s*error:\ze " nextgroup=shellcmdMsg
syn match shellcmdWarning "\c^\s*warning:\ze " nextgroup=shellcmdMsg
syn match shellcmdSpecialInfo '^\s\+Compiling\|Finished\|Running\s\+' nextgroup=shellcmdMsg
syn match shellcmdMsg ".*$" contained

syn match shellcmdTodo "\<\(TODO\|FIXME\|XXX\):"

hi def link shellcmdCargoPath String
hi def link shellcmdCargoPathNr Constant
hi def link shellcmdCmd Statement
hi def link shellcmdCmdPrompt Special
hi def link shellcmdGrepPath String
hi def link shellcmdGrepPathNr Constant
hi def link shellcmdPythonPath String
hi def link shellcmdPythonNr Constant

hi def link shellcmdError ErrorMsg
hi def link shellcmdWarning WarningMsg
hi def link shellcmdMsg Title
hi def link shellcmdSpecialInfo PreProc

hi def link shellcmdExitCodeNoErr Comment
hi def link shellcmdExitCodeErr WarningMsg

hi def link shellcmdTodo Todo

b:current_syntax = "shellcmd"
