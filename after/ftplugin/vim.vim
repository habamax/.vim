setl textwidth=80
setl keywordprg=:help
if !&readonly
    setlocal ff=unix
endif

let b:foldtext_strip_comments = v:true


setlocal path+=plugin/**
setlocal path+=autoload/**
setlocal path+=colortemplate/**
setlocal path+=after/**
setlocal path+=compiler/**
setlocal path+=colors/**
