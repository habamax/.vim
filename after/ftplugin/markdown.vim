setl commentstring=<!--%s-->

compiler md2pdf

" open files
nnoremap <buffer> <leader>op :silent !start %:p:r.pdf<CR>
nnoremap <buffer> <leader>od :silent !start %:p:r.docx<CR>
nnoremap <buffer> <leader>oh :silent !start %:p:r.html<CR>
