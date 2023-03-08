vim9script

if exists("b:current_syntax")
    finish
endif

syn match shellcmdCmd "\%^.*$" contains=shellcmdCmdPrompt
syn match shellcmdCmdPrompt "^\$" contained

syn match shellcmdCargoPath "-->\s\+.\{-}:\d\+:\d\+" contains=shellcmdCargoPathNr
syn match shellcmdCargoPathNr ":\d\+:\d\+" contained
syn match shellcmdCargoError "^error:"

syn match shellcmdGrepPath "^\S.\{-}\S:\(\d\+:\)\{1,2}" contains=shellcmdGrepPathNr
syn match shellcmdGrepPathNr ":\(\d\+:\)\{1,2}" contained

syn match shellcmdPythonLocation '^\s\+File ".\{-}", line \d\+' contains=shellcmdPythonPath,shellcmdPythonNr
syn match shellcmdPythonPath 'File "\zs.\{-}\ze"' contained
syn match shellcmdPythonNr "line \zs\d\+" contained

syn match shellcmdTodo "\<\(TODO\|FIXME\|XXX\):"

syn match shellcmdSpecialInfo '^\s\+Compiling\|Finished\|Running\s\+'

hi def link shellcmdCargoPath String
hi def link shellcmdCargoPathNr Constant
hi def link shellcmdCmd Statement
hi def link shellcmdCmdPrompt Special
hi def link shellcmdCargoError Error
hi def link shellcmdGrepPath String
hi def link shellcmdGrepPathNr Constant
hi def link shellcmdPythonPath String
hi def link shellcmdPythonNr Constant

hi def link shellcmdTodo Todo

hi def link shellcmdSpecialInfo Type

b:current_syntax = "shellcmd"
