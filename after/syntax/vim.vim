" fix marks incorrectly highlighted
" :'[,']sort
syn match vimExMarkRange /\(^\|\s\):['`][\[a-zA-Z0-9<][,;]['`][\]a-zA-Z0-9>]/

" clear excessive syntax highlighting
syn clear vimFuncName
syn clear vimVar
syn clear vimOperParen
syn clear vimOperError
syn clear vimUserAttrbError
