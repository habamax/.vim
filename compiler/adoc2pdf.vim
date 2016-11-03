" Vim compiler file
" Compiler:	adoc to pdf
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
  finish
endif
let current_compiler = "adoc2pdf"
let s:keepcpo= &cpo
set cpo&vim

let b:adoc_path_styles = shellescape(expand("~/docs/AsciiDocThemes"))
let b:adoc_path_fonts = shellescape(expand("~/docs/AsciiDocThemes/fonts"))

" let prg = "asciidoctor-pdf"
" To test out dev branch
let prg = "ruby C:/Users/maksim.kim/projects/asciidoctor-pdf/bin/asciidoctor-pdf"

let &l:makeprg = prg." -a pdf-stylesdir=".b:adoc_path_styles." -a pdf-fontsdir=".b:adoc_path_fonts." ".shellescape(expand("%:p"))

let &cpo = s:keepcpo
unlet s:keepcpo

