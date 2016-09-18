" Vim compiler file
" Compiler:	pandoc pdf
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "cs"
let s:keepcpo= &cpo
set cpo&vim

let &l:makeprg = "pandoc --reference-docx=".shellescape(expand("~/Documents/pandoc/templates/reference.docx"))." ".shellescape(expand("%:p"))." -s --smart -o ".shellescape(expand("%:p:r").".docx")

let &cpo = s:keepcpo
unlet s:keepcpo
