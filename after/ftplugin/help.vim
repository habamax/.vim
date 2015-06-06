nnoremap <buffer> <CR> <C-]>

nnoremap <buffer> <TAB> :silent call <SID>goto_help_link('next')<CR>
nnoremap <buffer> <S-TAB> :silent call <SID>goto_help_link('prev')<CR>

function! s:goto_help_link(dir)
  if a:dir == 'next'
    call search('|\zs\S\{-1,}|', '', '')
  else
    call search('|\zs\S\{-1,}|', 'b', '')
  endif
endfunction


let b:indentLine_enabled = 0
