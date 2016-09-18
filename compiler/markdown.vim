" Vim compiler file
" Compiler:	pandoc pdf
" Maintainer:Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "cs"
let s:keepcpo= &cpo
set cpo&vim

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" CompilerSet makeprg=pandoc\ --data-dir=\"C:/Users/maksim.kim/Documents/pandoc\"\ %:p\ -s\ --latex-engine=lualatex\ -o\ %:p:r.pdf

let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/Documents/pandoc"))." ".shellescape(expand("%:p"))." -s --smart --latex-engine=lualatex -o ".shellescape(expand("%:p:r").".pdf")

" CompilerSet makeprg=pandoc\ --data-dir=\"~/Documents/pandoc\"\ %:p\ -s\ --latex-engine=lualatex\ -o\ %:p:r.pdf


let &cpo = s:keepcpo
unlet s:keepcpo
