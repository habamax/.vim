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

def Next()
    try
        cnext
        exe "normal! \<CR>zz"
        if exists(":BlinkLine") == 2
            BlinkLine
        endif
        wincmd p
    catch
    endtry
enddef

def Prev()
    try
        cprev
        exe "normal! \<CR>zz"
        if exists(":BlinkLine") == 2
            BlinkLine
        endif
        wincmd p
    catch
    endtry
enddef

nnoremap <buffer> o <scriptcmd>Preview()<CR>
nnoremap <buffer> gq <scriptcmd>wincmd c<CR>
nnoremap <buffer> J <scriptcmd>Next()<CR>
nnoremap <buffer> K <scriptcmd>Prev()<CR>
