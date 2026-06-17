vim9script

if exists("g:current_compiler")
    finish
endif

g:current_compiler = "markdown_html"

# &l:makeprg = "pandoc -s --toc --toc-depth=3 -f gfm % -o %:p:t:r.html"
&l:makeprg = "pandoc -s -f gfm % -o %:r.html"

# mermaid-cli and mermaid-filter have to be installed for this
# &l:makeprg = "pandoc -s -f gfm -F mermaid-filter % -o %:r.html"
