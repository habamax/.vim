" Vim compiler file
" Compiler: adoc
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "adoc"
let s:keepcpo= &cpo
set cpo&vim

if exists("g:asciidoctor_extensions")
	let b:extensions = "-r ".join(g:asciidoctor_extensions, ' -r ')
endif
let &l:makeprg = "asciidoctor ".b:extensions." -a docdate=".strftime("%Y-%m-%d")." -a doctime=".strftime("%T")." ".shellescape(expand("%:p"))

let &cpo = s:keepcpo
unlet s:keepcpo

