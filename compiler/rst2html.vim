if exists("current_compiler")
    finish
endif

let current_compiler = "rst2html"
let s:keepcpo= &cpo
set cpo&vim

let s:input = shellescape(expand("%:p"))
let s:output = shellescape(expand("%:p:r").".html")

let &l:makeprg = printf("%s %s %s %s",
      \ 'rst2html5.py',
      \ get(g:, "g:rst2html_params",
      \       "--input-encoding=utf8"
      \     . " --table-style=align-center,booktabs,captionbelow"
      \     . " --stylesheet-path=minimal.css,responsive.css"
      \     . ",.docutils/habamax.css"),
      \ s:input,
      \ s:output
      \ )

let &cpo = s:keepcpo
unlet s:keepcpo


