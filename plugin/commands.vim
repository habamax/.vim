" Wipe all hidden buffers
command! Bclean call win#delete_buffers()


" remove trailing spaces
command! RemoveTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
            \:exe 'normal! ``'<bar>
            \:echo 'Remove trailing spaces and ^Ms.'


command! -range TextFixSpaces <line1>,<line2>call text#fix_spaces()
command! TextAddSpaces call text#add_spaces()

" Two columns.
" 1. Vertically split window
" 2. Offset it one screen
" 3. Scrollbind
command! TwoColumns
            \   exe "normal! zR"
            \ | set noscrollbind
            \ | vsplit
            \ | set scrollbind
            \ | wincmd w
            \ | exe "normal! \<c-f>"
            \ | set scrollbind
            \ | wincmd p

command! -range=% PasteVP call share#vpaste(<line1>, <line2>)
command! -range=% PasteDP call share#dpaste(<line1>, <line2>)
command! -range=% PasteIX call share#ix(<line1>, <line2>)
command! -range=% PasteCL call share#clbin(<line1>, <line2>)

command! CD lcd %:p:h

" Print the sum of the lines, awk is required.
command! -range Sum
            \ silent <line1>,<line2>copy <line2>
            \ <bar> silent '[,']!awk "{ sum += $0 } END { print sum }"

"" Save and Load sessions
command! -nargs=1 -complete=customlist,SessionComplete S :mksession! ~/.vimdata/sessions/<args>
command! -nargs=1 -complete=customlist,SessionComplete L :%bd <bar> so ~/.vimdata/sessions/<args>
func! SessionComplete(A, L, P)
    let fullpaths = split(globpath("~/.vimdata/sessions/", "*"), "\n")
    let result = map(fullpaths, {k,v -> fnamemodify(v, ":t")})
    if empty(a:A)
        return result
    else
        return result->matchfuzzy(a:A)
    endif
endfunc

" Write to a privileged file
if has("unix") || has("osxdarwin")
    command! W w !sudo tee "%" > /dev/null
endif


" open terminal with a cwd of a current buffer
command! TermBuffer :bo call term_start(&shell, {"cwd": expand("%:p:h"), "term_finish": "close", "term_rows": 10})

" run visual test for colorscheme
command! TestColorscheme exe "so colors/tools/colorscheme_sample.vim"


" Redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 -complete=command -bar -range Redir silent call tools#redir(<q-args>, <range>, <line1>, <line2>)
