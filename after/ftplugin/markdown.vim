setl commentstring=<!--%s-->

let &l:makeprg = "pandoc --data-dir=".shellescape(expand("~/docs/.pandoc"))." ".shellescape(expand("%:p"))." -s --pdf-engine=xelatex -o ".shellescape(expand("%:p:r").".pdf").' --listings'

" let &l:makeprg = "pandoc ".shellescape(expand("%:p"))." -s --pdf-engine=wkhtmltopdf -o ".shellescape(expand("%:p:r").".pdf")

