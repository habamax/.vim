nnoremap <buffer> <CR> <C-]>

nnoremap <buffer> <C-n> :silent call <SID>goto_help_link('next')<CR>
nnoremap <buffer> <C-p> :silent call <SID>goto_help_link('prev')<CR>

function! s:goto_help_link(dir)
    if a:dir == 'next'
        call search('|\zs\S\{-1,}|', '', '')
    else
        call search('|\zs\S\{-1,}|', 'b', '')
    endif
endfunction


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
