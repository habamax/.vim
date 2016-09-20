compiler md2pdf

" open files
nnoremap <buffer> <leader>mop :silent !%:p:r.pdf<CR>
nnoremap <buffer> <leader>mod :silent !%:p:r.docx<CR>
nnoremap <buffer> <leader>moh :silent !%:p:r.html<CR>

" change compilers
nnoremap <buffer> <leader>mcd :compiler md2docx<CR>
nnoremap <buffer> <leader>mcp :compiler md2pdf<CR>
nnoremap <buffer> <leader>mcx :compiler md2pdfx<CR>
nnoremap <buffer> <leader>mcl :compiler md2latex<CR>
