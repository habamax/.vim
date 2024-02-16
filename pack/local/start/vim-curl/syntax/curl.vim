if exists("b:current_syntax")
    finish
endif

syn include @curlJsonHighlight syntax/json.vim
unlet! b:current_syntax

syn match curlDashedParams "^--.*$" transparent contains=curlDashes,curlParam,curlURL,curlString,curlJsonData
syn match curlDashes "^--" contained
syn match curlParam "\(^--\)\@<=\S\+" contained
syn region curlString start='"' end='"' oneline contained contains=curlEscape
syn match curlURL "\(url\s\+\)\@<=.*$" contained
syn match curlEscape +\\['"\\]+ contained

syn region curlJsonData start='\(^--data\_s\+\)\@<={' end='^\s*$' contains=@curlJsonHighlight

syn match curlComment '^#.*$'

hi def link curlDashes Special
hi def link curlParam PreProc
hi def link curlURL Underlined
hi def link curlString String
hi def link curlEscape Special
hi def link curlComment Comment

let b:current_syntax = "curl"
