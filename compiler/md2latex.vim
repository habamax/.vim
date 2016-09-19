" Vim compiler file
" Compiler:	pandoc latex
" Maintainer:Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "pandoc2latex"
let s:keepcpo= &cpo
set cpo&vim

let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/docs"))." ".shellescape(expand("%:p"))." -s --smart --latex-engine=lualatex -o ".shellescape(expand("%:p:r").".tex")


let &cpo = s:keepcpo
unlet s:keepcpo
