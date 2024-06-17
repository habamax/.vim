vim9script

if exists("b:current_syntax")
    finish
endif

unlet! b:current_syntax

var delimiter = get(b:, "csv_delimiter", ",")

for col in range(8, 0, -1)
    var ncol = (col == 8 ? 0 : col + 1)
    exe $'syntax match csvCol{col}' .. ' /.\{-}\(' .. delimiter .. '\|$\)/ nextgroup=escCsvCol' .. ncol .. ',csvCol' .. ncol
    exe $'syntax region escCsvCol{col}' .. ' start=/ *"\([^"]*""\)*[^"]*/ end=/" *\(' .. delimiter .. '\|$\)/ nextgroup=escCsvCol' .. ncol .. ',csvCol' .. ncol
endfor

hi def link csvCol1 Statement
hi def link csvCol2 Constant
hi def link csvCol3 Type
hi def link csvCol4 PreProc
hi def link csvCol5 Identifier
hi def link csvCol6 Special
hi def link csvCol7 String
hi def link csvCol8 Comment

hi def link escCsvCol1 csvCol1
hi def link escCsvCol2 csvCol2
hi def link escCsvCol3 csvCol3
hi def link escCsvCol4 csvCol4
hi def link escCsvCol5 csvCol5
hi def link escCsvCol6 csvCol6
hi def link escCsvCol7 csvCol7
hi def link escCsvCol8 csvCol8

b:current_syntax = "csv"
