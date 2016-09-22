compiler md2pdf

" open files
nnoremap <buffer> <leader>mfp :silent !%:p:r.pdf<CR>
nnoremap <buffer> <leader>mfd :silent !%:p:r.docx<CR>
nnoremap <buffer> <leader>mfh :silent !%:p:r.html<CR>

" change compilers
nnoremap <buffer> <leader>mcd :compiler md2docx<CR>
nnoremap <buffer> <leader>mcp :compiler md2pdf<CR>
nnoremap <buffer> <leader>mcx :compiler md2pdfx<CR>
nnoremap <buffer> <leader>mcl :compiler md2latex<CR>
nnoremap <buffer> <leader>mch :compiler md2html<CR>
