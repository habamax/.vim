vim9script

if exists("b:current_syntax")
    finish
endif

syn match runTitle "\%^.*$"
syn match runCargoHintSign "\s\zs\^\+\ze\s"
syn match runCargoPath "-->\s\+\f\+:\d\+:\d\+" contains=runCargoPathNr
syn match runCargoPathNr ":\d\+:\d\+" contained
syn match runCargoError "^error:"

hi def link runCargoPath String
hi def link runCargoPathNr Constant
hi def link runTitle Statement
hi def link runCargoHintSign Identifier
hi def link runCargoError Error

b:current_syntax = "run"
