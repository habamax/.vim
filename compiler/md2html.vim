" Vim compiler file
" Compiler:	pandoc html
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "pandoc2html"
let s:keepcpo= &cpo
set cpo&vim

let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/docs"))." ".shellescape(expand("%:p"))." -s --smart --mathjax --number-sections -o ".shellescape(expand("%:p:r").".html")

let &cpo = s:keepcpo
unlet s:keepcpo
