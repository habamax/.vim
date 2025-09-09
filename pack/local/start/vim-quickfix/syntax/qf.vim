if exists("b:current_syntax")
  finish
endif

syn match qfFileName "^\f\+:\d\+:\(\d\+:\)\?" nextgroup=qfText contains=qfLineCol
" syn match qfFileName "^\f\+:\d\+:" nextgroup=qfText contains=qfLine
" syn match qfFileName "^\f\+:" nextgroup=qfText
syn match qfLineCol ":\d\+:\(\d\+:\)\?" contained
syn match qfText ".*" contained

syn match qfError "error" contained
syn cluster qfType contains=qfError

" The default highlighting.
hi def link qfFileName Type
hi def link qfLineCol PreProc
hi def link qfText Normal

hi def link qfError Error

let b:current_syntax = "qf"

" vim: ts=8
