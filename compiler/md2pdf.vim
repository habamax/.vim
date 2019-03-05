" Vim compiler file
" Compiler:	markdown to pdf
" Maintainer:Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif

let current_compiler = "md2pdf"
let s:keepcpo= &cpo
set cpo&vim

let s:exe = "pandoc"
let s:data_dir = " --data-dir=".shellescape(expand("~/docs/.pandoc"))
let s:resource_path = " --resource-path=.;".shellescape(expand("~/docs/.pandoc"))
let s:input = " ".shellescape(expand("%:p"))
let s:output = " -o ".shellescape(expand("%:p:r").".pdf")
let s:pdf_engine = " -s --pdf-engine=latexmk --pdf-engine-opt=-xelatex"
let s:oth_params = " --listings --lua-filter=plantuml.lua"

let &l:makeprg = s:exe.s:data_dir.s:input.s:output.s:resource_path.s:pdf_engine.s:oth_params

" setl errorformat=%f:%l:\ %m


let &cpo = s:keepcpo
unlet s:keepcpo

