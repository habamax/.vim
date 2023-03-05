vim9script

if exists("b:current_syntax")
    finish
endif

syn match runCargoHintSign "\s\zs\^\+\ze\s"
syn match runCargoPath "-->\s\+\f\+:\d\+:\d\+" contains=runCargoPathNr
syn match runCargoPathNr ":\d\+:\d\+" contained
syn match runCargoError "^error:"
syn match runGrepPath "^\f\+:\(\d\+:\)\?" contains=runGrepPathNr
syn match runGrepPathNr ":\d\+:" contained
syn match runGrep "^grep:.*$"
syn match runCmd "\%^.*$" contains=runCmdPrompt
syn match runCmdPrompt "^\$" contained

hi def link runCargoPath String
hi def link runCargoPathNr Constant
hi def link runCmd Statement
hi def link runCmdPrompt Identifier
hi def link runCargoHintSign WarningMsg
hi def link runCargoError Error
hi def link runGrepPath runCargoPath
hi def link runGrepPathNr runCargoPathNr

b:current_syntax = "run"
