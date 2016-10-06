compiler md2pdf

" open files
nnoremap <buffer> <leader>op :silent !%:p:r.pdf<CR>
nnoremap <buffer> <leader>od :silent !%:p:r.docx<CR>
nnoremap <buffer> <leader>oh :silent !%:p:r.html<CR>

" compile
nnoremap <buffer> <leader>cc :make<CR>

" change compilers
nnoremap <buffer> <leader>cd :compiler md2docx<CR>
nnoremap <buffer> <leader>cp :compiler md2pdf<CR>
nnoremap <buffer> <leader>cx :compiler md2pdfx<CR>
nnoremap <buffer> <leader>cl :compiler md2latex<CR>
nnoremap <buffer> <leader>ch :compiler md2html<CR>


inorea <buffer> options: ---
			\<CR>title:
			\<CR>subtitle:
			\<CR>subtitle2:
			\<CR>author: Максим Ким
			\<CR>titlepage: yes
			\<CR>lang: ru
			\<CR>toc: yes
			\<CR>documentclass: article
			\<CR>logoleft: logo-semanta-black.png
			\<CR>logoleft-scale: 0.21
			\<CR>logoright: logo-adastra.png
			\<CR>logoright-scale: 0.11
			\<CR>...

inorea <buffer> -> \to{}
inorea <buffer> -. \to{}
inorea <buffer> -Ю \to{}
inorea <buffer> -ю \to{}
