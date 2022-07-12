fun! s:help_heading()
    let line = getline('.')
    let matches = matchlist(line, '\v^(.{-})\s+(\S*)\s*$')
    if len(matches) > 2
        let tw = 80
        let padstr = repeat(' ', max([1, tw - len(matches[1]) - len(matches[2])]))
        call setline('.', printf('%s%s%s', matches[1], padstr, matches[2]))
    endif
endfu

nnoremap <buffer> <space><space><space> :call <sid>help_heading()<CR>
nnoremap <buffer> <cr> <C-]>
nnoremap <buffer> o <C-]>
nnoremap <buffer> u <C-t>
nnoremap <buffer> J <cmd>call search('\|[^\|[:space:]]\+\|', 'z')<cr>
nnoremap <buffer> K <cmd>call search('\|[^\|[:space:]]\+\|', 'zb')<cr>
