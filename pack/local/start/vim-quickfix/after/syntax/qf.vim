syn match qfFileNameC "^\f\+:\d\+:\(\d\+:\)\?" nextgroup=qfText contains=qfLineNrC
syn match qfLineNrC ":\d\+:\(\d\+:\)\?" contained

hi def link qfFileNameC qfFileName
hi def link qfLineNrC qfLineNr
