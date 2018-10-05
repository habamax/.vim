" Vim compiler file
" Compiler: adoc to pdf
" Maintainer: Maxim Kim (habamax@gmail.com)

if exists("current_compiler")
	finish
endif
let current_compiler = "adoc2pdf"
let s:keepcpo= &cpo
set cpo&vim

let b:pdf_styles = '-a pdf-stylesdir='.shellescape(expand(g:asciidoctor_pdf_themes_path))
let b:pdf_fonts = '-a pdf-fontsdir='.shellescape(expand(g:asciidoctor_pdf_fonts_path))

if exists("g:asciidoctor_pdf_extensions")
	let b:extensions = "-r ".join(g:asciidoctor_pdf_extensions, ' -r ')
endif

let prg = "asciidoctor-pdf"

let &l:makeprg = prg." ".b:extensions." -a docdate=".strftime("%Y-%m-%d")." -a doctime=".strftime("%T")." ".b:pdf_styles." ".b:pdf_fonts." ".shellescape(expand("%:p"))

" let &l:makeprg = prg." -r asciidoctor-diagram -a pdf-stylesdir=".b:adoc_path_styles." -a pdf-fontsdir=".b:adoc_path_fonts." ".shellescape(expand("%:p"))

let &cpo = s:keepcpo
unlet s:keepcpo

