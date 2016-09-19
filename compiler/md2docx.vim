" Vim compiler file
" Compiler:	pandoc docx
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "pandoc2docx"
let s:keepcpo= &cpo
set cpo&vim

let &l:makeprg = "pandoc --reference-docx=".shellescape(expand("~/docs/templates/reference.docx"))." ".shellescape(expand("%:p"))." -s --smart -o ".shellescape(expand("%:p:r").".docx")

let &cpo = s:keepcpo
unlet s:keepcpo
