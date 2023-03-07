vim9script

if exists("b:current_syntax")
    finish
endif

syn match runCmd "\%^.*$" contains=runCmdPrompt
syn match runCmdPrompt "^\$" contained

syn match runCargoPath "-->\s\+\f\+:\d\+:\d\+" contains=runCargoPathNr
syn match runCargoPathNr ":\d\+:\d\+" contained
syn match runCargoError "^error:"

syn match runGrepPath "^[./]\f\+:\(\d\+:\)\{,2}" contains=runGrepPathNr
syn match runGrepPathNr ":\(\d\+:\)\{1,2}" contained

syn match runPythonLocation '^\s\+File "\f\+", line \d\+' contains=runPythonPath,runPythonNr
syn match runPythonPath 'File "\zs\f\+\ze"' contained
syn match runPythonNr "line \zs\d\+" contained

syn match runTodo "\<\(TODO\|FIXME\|XXX\):"

syn match runSpecialInfo '^\s\+Compiling\|Finished\|Running\s\+'

hi def link runCargoPath String
hi def link runCargoPathNr Constant
hi def link runCmd Statement
hi def link runCmdPrompt Identifier
hi def link runCargoError Error
hi def link runGrepPath String
hi def link runGrepPathNr Constant
hi def link runPythonPath String
hi def link runPythonNr Constant

hi def link runTodo Todo

hi def link runSpecialInfo Type

b:current_syntax = "run"
