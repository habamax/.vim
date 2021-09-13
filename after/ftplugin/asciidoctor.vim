compiler asciidoctor2pdf

setlocal path+=**/*

setl cole=3

let b:comment_first_col = 1

nnoremap <buffer> <space><space>oo :AsciidoctorOpenRAW<CR>
nnoremap <buffer> <space><space>oh :AsciidoctorOpenHTML<CR>
nnoremap <buffer> <space><space>ox :AsciidoctorOpenDOCX<CR>
nnoremap <buffer> <space><space>op :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <space><space>cp :Asciidoctor2PDF<CR>
nnoremap <buffer> <space><space>cx :Asciidoctor2DOCX<CR>
nnoremap <buffer> <space><space>ch :Asciidoctor2HTML<CR>
nnoremap <buffer> <space><space>p :AsciidoctorPasteImage<CR>

nmap <buffer> <space><tab> <Plug>(AsciidoctorFold)
nmap <buffer> >h <Plug>(AsciidoctorSectionPromote)
nmap <buffer> <h <Plug>(AsciidoctorSectionDemote)
