" highlight all occurrences of a term being searched/replaced
augroup hlsearch | au!
    au CmdlineEnter /,\? :set hlsearch
    au CmdlineLeave /,\? :set nohlsearch
augroup end


" restore cursor position
augroup restore_pos | au!
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe 'normal! g`"'
                \ | endif
augroup end


" window autosize
augroup win_autosize | au!
    au WinEnter * silent! call win#lens()
augroup end


" detect indent
" augroup indentector | au!
"     au FileType * call indentector#detect_indent(getline(1, 1024))
" augroup END


" <+placeholder+> highlight
augroup placeholder | au!
    au BufNew,BufRead * call matchadd('Error', '<+.\{-}+>')
augroup END
