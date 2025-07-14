vim9script

if exists("b:did_after_ftplugin")
    finish
endif
b:did_after_ftplugin = 1

nnoremap <buffer> <space><space>r :Curl<CR>
xnoremap <buffer> <space><space>r :Curl<CR>
