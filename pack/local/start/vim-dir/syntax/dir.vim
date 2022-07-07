vim9script

if exists("b:current_syntax")
    finish
endif

syn match dirTitle "^permission.*name$"
syn match dirType "^[-djl]" nextgroup=dirPermissionUser
syn match dirPermissionUser "[-r][-w][-x]" nextgroup=dirPermissionGroup
syn match dirPermissionGroup "[-r][-w][-x]" nextgroup=dirPermissionOther
syn match dirPermissionOther "[-r][-w][-x]" contained


hi def link dirTitle Title
hi def link dirType Type
hi def link dirPermissionUser Statement
hi def link dirPermissionGroup Type
hi def link dirPermissionOther Statement

b:current_syntax = "dir"
