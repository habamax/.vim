"" Return unicode number up to 20 or just a number if > 20
""
"" Second function argument is boolean (default is v:true)
"" Whether to return negative or non-negative number chars
"" 
"" Used in statusline.vim and tabline.vim
func! misc#unicode_number(num, ...) abort
    let num = a:num
    if get(a:, 1, v:true)
        if a:num > 0 && a:num <= 10
            let num = nr2char(char2nr('❶') + (a:num - 1)) . ' '
        elseif a:num <= 20
            let num = nr2char(char2nr('⓫') + (a:num - 11)) . ' '
        endif
    else
        if a:num > 0 && a:num <= 20
            let num = nr2char(char2nr('①') + (a:num - 1)) . ' '
        endif
    endif
    return num
endfunc
