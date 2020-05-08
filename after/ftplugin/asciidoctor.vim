compiler asciidoctor2pdf

let b:foldtext_strip_add_regex = '^=\+'

setl cole=3

nnoremap <buffer> <leader>moo :AsciidoctorOpenRAW<CR>
nnoremap <buffer> <leader>moh :AsciidoctorOpenHTML<CR>
nnoremap <buffer> <leader>mox :AsciidoctorOpenDOCX<CR>
nnoremap <buffer> <leader>mop :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <leader>mmp :Asciidoctor2PDF<CR>
nnoremap <buffer> <leader>mmx :Asciidoctor2DOCX<CR>
nnoremap <buffer> <leader>mmh :Asciidoctor2HTML<CR>
nnoremap <buffer> <leader>mp :AsciidoctorPasteImage<CR>

