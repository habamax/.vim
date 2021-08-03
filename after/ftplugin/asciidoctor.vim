compiler asciidoctor2pdf

setlocal path+=**/*

setl cole=3

nnoremap <buffer> <space><space>oo :AsciidoctorOpenRAW<CR>
nnoremap <buffer> <space><space>oh :AsciidoctorOpenHTML<CR>
nnoremap <buffer> <space><space>ox :AsciidoctorOpenDOCX<CR>
nnoremap <buffer> <space><space>op :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <space><space>cp :Asciidoctor2PDF<CR>
nnoremap <buffer> <space><space>cx :Asciidoctor2DOCX<CR>
nnoremap <buffer> <space><space>ch :Asciidoctor2HTML<CR>
nnoremap <buffer> <space><space>p :AsciidoctorPasteImage<CR>


inorea <buffer> nbsp {nbsp}<C-R>=Eatchar('\s')<CR>
inorea <buffer> zwsp {zwsp}<C-R>=Eatchar('\s')<CR>
inorea <buffer> blnk {blank}<C-R>=Eatchar('\s')<CR>


nmap <buffer> <space><tab> <Plug>(AsciidoctorFold)
nmap <buffer> >h <Plug>(AsciidoctorSectionPromote)
nmap <buffer> <h <Plug>(AsciidoctorSectionDemote)
