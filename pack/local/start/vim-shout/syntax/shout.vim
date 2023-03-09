vim9script

if exists("b:current_syntax")
    finish
endif

syn match shoutCmd "\%^.*$" contains=shoutCmdPrompt
syn match shoutCmdPrompt "^\$" contained
syn match shoutExitCodeErr "^Exit code: .*\%$"
syn match shoutExitCodeNoErr "^Exit code: 0\%$"

syn match shoutCargoPath "-->\s\+.\{-}:\d\+:\d\+" contains=shoutCargoPathNr
syn match shoutCargoPathNr ":\d\+:\d\+" contained

syn match shoutGrepPath "^\S.\{-}\S:\(\d\+:\)\{1,2}" contains=shoutGrepPathNr
syn match shoutGrepPathNr ":\(\d\+:\)\{1,2}" contained

syn match shoutPythonLocation '^\s\+File ".\{-}", line \d\+' contains=shoutPythonPath,shoutPythonNr
syn match shoutPythonPath 'File "\zs.\{-}\ze"' contained
syn match shoutPythonNr "line \zs\d\+" contained

syn match shoutError "\c^\s*error:\ze " nextgroup=shoutMsg
syn match shoutWarning "\c^\s*warning:\ze " nextgroup=shoutMsg
syn match shoutSpecialInfo '^\s\+Compiling\|Finished\|Running\s\+' nextgroup=shoutMsg
syn match shoutMsg ".*$" contained

syn match shoutTodo "\<\(TODO\|FIXME\|XXX\):"

hi def link shoutCargoPath String
hi def link shoutCargoPathNr Constant
hi def link shoutCmd Statement
hi def link shoutCmdPrompt Special
hi def link shoutGrepPath String
hi def link shoutGrepPathNr Constant
hi def link shoutPythonPath String
hi def link shoutPythonNr Constant

hi def link shoutError ErrorMsg
hi def link shoutWarning WarningMsg
hi def link shoutMsg Title
hi def link shoutSpecialInfo PreProc

hi def link shoutExitCodeNoErr Comment
hi def link shoutExitCodeErr WarningMsg

hi def link shoutTodo Todo

b:current_syntax = "shout"
