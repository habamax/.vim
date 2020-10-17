if exists("b:current_syntax")
    finish
endif

syn match ircNonMessage '^---.*$'
syn match ircNonMessage '.*-!- Irssi:.*$'
syn match ircNonMessage '.*-ChanServ.*$'
syn match ircMeMessage '^\d\+:\d\+\s\+\*\s.*$'

syn keyword ircMyName habamax

syn match ircPrefix '^\d\+:\d\+\s*<[^>]\+>' transparent contains=ircTimestamp,ircName
syn match ircTimestamp '^\d\+:\d\+' contained nextgroup=ircName
syn match ircName '<[^>]\+>' contained contains=ircMyName


hi def link ircTimestamp PreProc
hi def link ircName Identifier
hi def link ircMyName Statement
hi def link ircNonMessage Comment
hi link ircMeMessage String

let b:current_syntax = "irclog"

