compiler asciidoctor2pdf

let b:foldtext_strip_add_regex = '^=\+'

setl cole=3

nnoremap <buffer> <leader><leader>oo :AsciidoctorOpenRAW<CR>
nnoremap <buffer> <leader><leader>oh :AsciidoctorOpenHTML<CR>
nnoremap <buffer> <leader><leader>ox :AsciidoctorOpenDOCX<CR>
nnoremap <buffer> <leader><leader>op :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <leader><leader>cp :Asciidoctor2PDF<CR>
nnoremap <buffer> <leader><leader>cx :Asciidoctor2DOCX<CR>
nnoremap <buffer> <leader><leader>ch :Asciidoctor2HTML<CR>
nnoremap <buffer> <leader><leader>p :AsciidoctorPasteImage<CR>

