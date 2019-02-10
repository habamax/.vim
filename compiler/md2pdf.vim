" Vim compiler file
" Compiler:	markdown to pdf
" Maintainer:Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif

let current_compiler = "md2pdf"
let s:keepcpo= &cpo
set cpo&vim

" let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/docs/.pandoc"))." ".shellescape(expand("%:p"))." -s --pdf-engine=xelatex -o ".shellescape(expand("%:p:r").".pdf").' --listings'

let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/docs/.pandoc"))." ".shellescape(expand("%:p"))." -s --pdf-engine=xelatex -o ".shellescape(expand("%:p:r").".pdf").' --listings --filter pandoc-plantuml'
" setl errorformat=%f:%l:\ %m


let &cpo = s:keepcpo
unlet s:keepcpo

