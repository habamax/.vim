if exists("b:current_syntax")
    finish
endif



syn match ircMessage '^.*$' contains=ircTimestamp,ircNick
syn match ircTimestamp '^\d\d:\d\d' contained nextgroup=ircNick
syn match ircNick '<[^>]\+>' contained contains=ircNickSep,ircNickMe
syn match ircNickSep '[<>]' contained
syn match ircNickMe 'habamax' contained

syn match ircMessageMention '^\d\d:\d\d\s<[^>]\+>\s.*habamax.*$' contains=ircTimestamp,ircNickMention,ircNickMe
syn match ircNickMention '<[^>]\+>' contained contains=ircNickSep
syn match ircMessageBodyMention '^\d\d:\d\d\s<[^>]\+>\s\zs.*$' contained contains=ircNickMe


syn match ircNonMessage '^---.*$'
syn match ircNonMessage '.*-!- Irssi:.*$'
syn match ircNonMessage '.*-ChanServ.*$'

hi link ircTimestamp Normal
hi link ircNickSep Comment
hi link ircNick PreProc
hi link ircNickMention SpecialComment
hi link ircNickMe Statement
hi link ircMessageMention Title

let b:current_syntax = "irclog"
