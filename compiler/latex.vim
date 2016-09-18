" Vim compiler file
" Compiler:	lualatex
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

CompilerSet makeprg=lualatex\ -file-line-error\ -shell-escape\ -interaction=nonstopmode\ -output-directory\ %:p:h\ %:p
CompilerSet errorformat=%f:%l:\ %m


let &cpo = s:keepcpo
unlet s:keepcpo
