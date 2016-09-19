" Vim compiler file
" Compiler:	pandoc pdf
" Maintainer:Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "pandoc2pdf"
let s:keepcpo= &cpo
set cpo&vim

let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/docs"))." ".shellescape(expand("%:p"))." -s --smart --latex-engine=xelatex -o ".shellescape(expand("%:p:r").".pdf")

let &cpo = s:keepcpo
unlet s:keepcpo
