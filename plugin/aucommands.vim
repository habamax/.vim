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


augroup colorscheme | au!
    hi VertSplit guibg=NONE ctermbg=NONE
    au Colorscheme noco,saturnite,bronzage,sugarlily hi VertSplit guibg=NONE ctermbg=NONE
    au Colorscheme sugarlily hi Normal guibg=#e4e4e4 ctermbg=254
augroup END


if exists("$WSLENV")
    augroup WSLClip | au!
        au TextYankPost * if v:event.regname == '"' | call system("clip.exe ", v:event.regcontents) | endif
    augroup END
endif
