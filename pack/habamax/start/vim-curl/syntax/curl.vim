if exists("b:current_syntax")
    finish
endif

syn match curlDashedParams "^--.*$" transparent contains=curlDashes,curlParam,curlURL,curlString
syn match curlDashes "^--" contained
syn match curlParam "\(^--\)\@<=\S\+" contained
syn region curlString start='"' end='"' oneline contained contains=curlEscape
syn match curlURL "\%(file\|http\|ftp\|irc\)s\?://\S\+\%(\[.\{-}\]\)\?" contained
syn match curlEscape +\\['"\\]+ contained

hi def link curlDashes Special
hi def link curlParam Statement
hi def link curlURL Underlined
hi def link curlString String
hi def link curlEscape Special

let b:current_syntax = "curl"
