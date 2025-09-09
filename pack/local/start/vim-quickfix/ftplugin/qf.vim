vim9script

def Preview()
    if !getqflist()[line('.') - 1].valid
        return
    endif
    exe "normal! \<CR>zz"
    if exists(":BlinkLine") == 2
        BlinkLine
    endif
    wincmd p
enddef

nnoremap <buffer> o <scriptcmd>Preview()<CR>
nnoremap <buffer> gq <scriptcmd>wincmd c<CR>
