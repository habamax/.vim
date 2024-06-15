vim9script

if exists("b:current_syntax")
    finish
endif

unlet! b:current_syntax

# TODO: detect delimiter in filetype

syntax match csvCol8 /.\{-}\(,\|$\)/ nextgroup=escCsvCol0,csvCol0
syntax match escCsvCol8 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol0,csvCol0
syntax match csvCol7 /.\{-}\(,\|$\)/ nextgroup=escCsvCol8,csvCol8
syntax match escCsvCol7 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol8,csvCol8
syntax match csvCol6 /.\{-}\(,\|$\)/ nextgroup=escCsvCol7,csvCol7
syntax match escCsvCol6 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol7,csvCol7
syntax match csvCol5 /.\{-}\(,\|$\)/ nextgroup=escCsvCol6,csvCol6
syntax match escCsvCol5 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol6,csvCol6
syntax match csvCol4 /.\{-}\(,\|$\)/ nextgroup=escCsvCol5,csvCol5
syntax match escCsvCol4 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol5,csvCol5
syntax match csvCol3 /.\{-}\(,\|$\)/ nextgroup=escCsvCol4,csvCol4
syntax match escCsvCol3 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol4,csvCol4
syntax match csvCol2 /.\{-}\(,\|$\)/ nextgroup=escCsvCol3,csvCol3
syntax match escCsvCol2 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol3,csvCol3
syntax match csvCol1 /.\{-}\(,\|$\)/ nextgroup=escCsvCol2,csvCol2
syntax match escCsvCol1 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol2,csvCol2
syntax match csvCol0 /.\{-}\(,\|$\)/ nextgroup=escCsvCol1,csvCol1
syntax match escCsvCol0 / *"\([^"]*""\)*[^"]*" *\(,\|$\)/ nextgroup=escCsvCol1,csvCol1

hi def link csvCol1 Statement
hi def link escCsvCol1 csvCol1
hi def link csvCol2 Constant
hi def link escCsvCol2 csvCol2
hi def link csvCol3 Type
hi def link escCsvCol3 csvCol3
hi def link csvCol4 Identifier
hi def link escCsvCol4 csvCol4
hi def link csvCol5 PreProc
hi def link escCsvCol5 csvCol5
hi def link csvCol6 String
hi def link escCsvCol6 csvCol6
hi def link csvCol7 Special
hi def link escCsvCol7 csvCol7
hi def link csvCol8 Comment
hi def link escCsvCol8 csvCol8

b:current_syntax = "csv"
