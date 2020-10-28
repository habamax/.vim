"" Non Plugin Mappings {{{1

" clipoard yank and paste
noremap <space>y "+y
noremap <space>p "+p
noremap <space>P "+P

" tab to cycle search candidates
cnoremap <expr> <Tab>   getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"

" insert current line into command line
cnoremap <M-l> <C-r><C-l>

nnoremap <space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" guards
nnoremap <space>f <nop>

nnoremap <BS> <C-^>

" UPPERCASE WORD
nnoremap <silent> <M-u> gUiww
" lowercase WORD
nnoremap <silent> <M-U> guiww

" UPPERCASE word in insert mode
inoremap <silent> <M-u> <ESC>gUiw`]a
" lowercase word in insert mode
inoremap <silent> <M-U> <ESC>guiw`]a


" Move line up/down
nnoremap <silent> <M-p> :<C-u>silent! exe "move-2"<CR>==
nnoremap <silent> <M-n> :<C-u>silent! exe "move+1"<CR>==
inoremap <silent> <M-p> <ESC>:<C-u>silent! exe "move-2"<CR>==gi
inoremap <silent> <M-n> <ESC>:<C-u>silent! exe "move+1"<CR>==gi
" Move selected lines up/down
xnoremap <silent> <M-p> :<C-u>silent! exe "'<,'>move-2"<CR>gv=gv
xnoremap <silent> <M-n> :<C-u>silent! exe "'<,'>move'>+"<CR>gv=gv

nnoremap <M-v> <C-v>
xnoremap <M-v> <C-v>

nnoremap <M-f> <C-d>
xnoremap <M-f> <C-d>
nnoremap <M-b> <C-u>
xnoremap <M-b> <C-u>

"" Window management
" switch to windows
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <space>q <C-w>c
nnoremap <space>ws <C-w>s
nnoremap <space>wv <C-w>v
nnoremap <space>wn <C-w>n
nnoremap <silent> <space>wo :call win#zoom_toggle()<CR>
nnoremap <space>wh <C-w>H
nnoremap <space>wl <C-w>L
nnoremap <space>wj <C-w>J
nnoremap <space>wk <C-w>K

nnoremap <silent> <F2> :echo win#layout_toggle()<CR>


"" indent text object
onoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
onoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
xnoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
xnoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>

"" number text object
func! s:number()
    if search('\d\([^0-9\.]\|$\)', 'cW')
        normal v
        call search('\(^\|[^0-9\.]\d\)', 'becW')
    endif
endfunc
xnoremap <silent> in :<C-u>call <SID>number()<CR>
onoremap in :<C-u>normal vin<CR>

" date text object
xnoremap <silent> id :<C-u>call text#obj_date(1)<CR>
onoremap id :<C-u>normal vid<CR>
xnoremap <silent> ad :<C-u>call text#obj_date(0)<CR>
onoremap ad :<C-u>normal vad<CR>

"" line text object
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <M-s> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u

nnoremap <space>t<space> i<space><right><space><ESC>h

" Fix text (remove double spaces, hanging spaces, etc)
nnoremap <space>tf :TextFixSpaces<CR>
xnoremap <space>tf :TextFixSpaces<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" shift right and left
xnoremap > >gv
xnoremap < <gv

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

nnoremap <space>- :call text#underline(['-', '=', '~', '^', '+'])<CR>
nnoremap <space>= :call text#underline(['=', '-', '~', '^', '+'])<CR>
nnoremap <space>~ :call text#underline(['~', '=', '-', '^', '+'])<CR>
nnoremap <space>^ :call text#underline(['^', '=', '-', '~', '+'])<CR>
nnoremap <space>+ :call text#underline(['+', '=', '-', '~', '^'])<CR>

nnoremap <space><space>- o<home><ESC>78i-<ESC>
nnoremap <space><space>= o<home><ESC>78i=<ESC>

" find visually selected text
vnoremap * y/<C-R>"<CR>

nnoremap <silent> <space>i :call git#show_commit()<CR>

" edit mappings file
nnoremap <silent> <space>em :exe printf('e %s/plugin/mappings.vim', fnamemodify($MYVIMRC, ":p:h"))<CR>
" edit global todo file
nnoremap <silent> <space>et :exe printf('e %s/docs/todo.adoc', empty($DOCSHOME)?expand('~'):expand($DOCSHOME))<CR>
" edit global journal file
nnoremap <silent> <space>ej :call journal#new()<CR>

" scroll other window
nnoremap <silent> <M-F> :call win#scroll_other(1)<CR>
nnoremap <silent> <M-B> :call win#scroll_other(0)<CR>

nnoremap <silent> gof :call os#file_manager()<CR>


" Save as
nnoremap <expr> <space>S printf(":saveas %s%s",
            \ expand("%:p"),
            \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))


" Sort operator
func! Sort(type, ...)
    '[,']sort
endfunc
nmap <silent> gs :set opfunc=Sort<CR>g@
vmap <silent> gs :sort<CR>


"" Commands (and Autocommands) {{{1

cabbr ц w
cabbr й q
cabbr цй wq
cabbr ив bd

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

" highlight all occurrences of a term being searched/replaced
augroup hlsearch | au!
    au CmdlineEnter /,\? :set hlsearch
    au CmdlineLeave /,\? :set nohlsearch
augroup end

augroup restore_pos | au!
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup end

augroup win_autosize | au!
    au WinEnter * silent! call win#lens()
augroup end
