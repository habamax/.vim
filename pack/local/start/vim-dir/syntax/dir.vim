vim9script

if exists("b:current_syntax")
    finish
endif

syn match dirCwd "\%^.*$"

syn match dirDirectory "^[dj].*$" contains=dirType
syn match dirFile "^[-].*$" contains=dirType
syn match dirLink "^[l].*$" contains=dirType

syn match dirType "^[-djl]" contained nextgroup=dirPermissionUser
syn match dirPermissionUser "[-r][-w][-x]" contained nextgroup=dirPermissionGroup
syn match dirPermissionGroup "[-r][-w][-x]" contained nextgroup=dirPermissionOther
if has("win32")
    syn match dirPermissionOther "[-r][-w][-x]" contained nextgroup=dirSize skipwhite
else
    syn match dirPermissionOther "[-r][-w][-x]" contained nextgroup=dirOwner skipwhite
    syn match dirOwner "\S\+" contained nextgroup=dirGroup skipwhite
    syn match dirGroup "\S\+" contained nextgroup=dirSize skipwhite
endif
syn match dirSize "\d\+[KMG]\?" contained nextgroup=dirTime contains=dirSizeMod skipwhite
syn match dirSizeMod "[KMG]" contained
syn match dirTime "\d\{4}-\d\{2}-\d\{2}\s\d\d:\d\d" contained nextgroup=dirName skipwhite
syn match dirName ".*$" contained transparent


hi def link dirCwd Title
hi def link dirType Type
hi def link dirPermissionUser Constant
hi def link dirPermissionGroup PreProc
hi def link dirPermissionOther Special
hi def link dirOwner Identifier
hi def link dirGroup Identifier
hi def link dirSize Constant
hi def link dirSizeMod Type
hi def link dirTime String
hi def link dirDirectory Directory
hi def link dirLink Type

b:current_syntax = "dir"
