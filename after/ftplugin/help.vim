fun! s:help_heading()
    let line = getline('.')
    let matches = matchlist(line, '\v^(.{-})\s+(\S*)\s*$')
    if len(matches) > 2
        let tw = &textwidth == 0 ? 78 : &textwidth
        let padstr = repeat(' ', max([1, tw - len(matches[1]) - len(matches[2])]))
        call setline('.', printf('%s%s%s', matches[1], padstr, matches[2]))
    endif
endfu

nnoremap <buffer> <space><space><space> :call <sid>help_heading()<CR>
