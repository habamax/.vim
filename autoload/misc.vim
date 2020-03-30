"" Return unicode number up to 10 or just a number if > 10
"" Used in statusline.vim and tabline.vim
func! misc#unicode_number(num) abort
  if a:num > 0 && a:num <= 10
    return nr2char(char2nr('❶') + (a:num - 1)) . ' '
  else
    return a:num
  endif
endfunc
