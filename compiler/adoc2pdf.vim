" Vim compiler file
" Compiler:	adoc to pdf
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "adoc2pdf"
let s:keepcpo= &cpo
set cpo&vim

let &l:makeprg = "asciidoctor-pdf ".shellescape(expand("%:p"))

let &cpo = s:keepcpo
unlet s:keepcpo

