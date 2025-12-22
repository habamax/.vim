vim9script

if exists("g:current_compiler")
    finish
endif

g:current_compiler = "markdown_html"

&l:makeprg = "pandoc -s --toc --toc-depth=3 -f gfm % -o %:t:r.html"
