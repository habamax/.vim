"" How do you find current server name/type?

" unlet b:current_syntax
" syn include @LspHoverSourceHighlight syntax/python.vim
" syn region lsp_hover_heading start=+\%1l^+ end=+$+ contains=@LspHoverSourceHighlight


"" Do not use syntax for the first line of hover data
syn region lsp_hover_heading start=+\%1l^+ end=+$+
