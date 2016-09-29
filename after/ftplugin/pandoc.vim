compiler md2pdf

" open files
nnoremap <buffer> <leader>op :silent !%:p:r.pdf<CR>
nnoremap <buffer> <leader>od :silent !%:p:r.docx<CR>
nnoremap <buffer> <leader>oh :silent !%:p:r.html<CR>

" change compilers
nnoremap <buffer> <leader>cd :compiler md2docx<CR>
nnoremap <buffer> <leader>cp :compiler md2pdf<CR>
nnoremap <buffer> <leader>cx :compiler md2pdfx<CR>
nnoremap <buffer> <leader>cl :compiler md2latex<CR>
nnoremap <buffer> <leader>ch :compiler md2html<CR>
