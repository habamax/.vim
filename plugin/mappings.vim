"" Non Plugin Mappings {{{1

let mapleader = "\<Space>"

" clipoard yank and paste
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P

" tab to cycle search candidates
cnoremap <expr> <Tab>   getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"

" insert current line into command line
cnoremap <M-l> <C-r><C-l>

nnoremap <leader>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" guards
nnoremap <leader>m <nop>
nnoremap <leader>o <nop>
nnoremap <leader>d <nop>
nnoremap d<leader> <nop>

nnoremap <BS> <C-^>
" kill-all buffers except current one
" nnoremap <M-BS> :%bd\|e#\|bd#<CR>

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

nnoremap <leader>q <C-w>c
nnoremap <leader>ws <C-w>s
nnoremap <leader>wv <C-w>v
nnoremap <leader>wn <C-w>n
nnoremap <silent> <leader>wo :call win#zoom_toggle()<CR>
nnoremap <leader>wh <C-w>H
nnoremap <leader>wl <C-w>L
nnoremap <leader>wj <C-w>J
nnoremap <leader>wk <C-w>K
" maximize window
nnoremap <leader>wm <C-w>_<C-w>\|

" goto window
for wnr in range(1, 9)
    exe printf("nnoremap <space>%s %s<C-w>w", wnr, wnr)
    exe printf("nnoremap %s<space> %s<C-w>w", wnr, wnr)
endfor


nnoremap <silent> <F2> :echo win#layout_toggle()<CR>
nnoremap <silent> <leader>w1 :echo win#layout_horizontal()<CR>
nnoremap <silent> <leader>w2 :echo win#layout_vertical()<CR>
nnoremap <silent> <leader>w3 :echo win#layout_main_horizontal()<CR>
nnoremap <silent> <leader>w4 :echo win#layout_main_vertical()<CR>
nnoremap <silent> <leader>w5 :echo win#layout_tile()<CR>

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


" just one space on the line, preserving indent
nnoremap <leader><leader><leader> :FixText<CR>
xnoremap <leader><leader><leader> :FixText<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" shift right and left
xnoremap > >gv
xnoremap < <gv

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

nnoremap <leader>- :call text#underline(['-', '=', '~', '^', '+'])<CR>
nnoremap <leader>= :call text#underline(['=', '-', '~', '^', '+'])<CR>
nnoremap <leader>~ :call text#underline(['~', '=', '-', '^', '+'])<CR>
nnoremap <leader>^ :call text#underline(['^', '=', '-', '~', '+'])<CR>
nnoremap <leader>+ :call text#underline(['+', '=', '-', '~', '^'])<CR>

nnoremap <leader><leader>- o<home><ESC>78i-<ESC>
nnoremap <leader><leader>= o<home><ESC>78i=<ESC>

" find visually selected text
vnoremap * y/<C-R>"<CR>

nnoremap <leader>z zA

" edit init file
nnoremap <silent> <leader>ei :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/vimrc"<CR>


" Directory ~/docs
nnoremap <silent> <leader>dd :Docs<CR>
" Directory ~/vimfiles or ~/.vim
nnoremap <silent> <leader>dv :VimConfigs<CR>

nnoremap <silent> <leader>i :call git#show_commit()<CR>

" edit global todo file
nnoremap <silent> <leader>et :exe printf('e %s/docs/todo.adoc', empty($DOCSHOME)?expand('~'):expand($DOCSHOME))<CR>
" edit global journal file
nnoremap <silent> <leader>ej :call journal#new()<CR>

" scroll other window
nnoremap <silent> <M-F> :call win#scroll_other(1)<CR>
nnoremap <silent> <M-B> :call win#scroll_other(0)<CR>

nnoremap <silent> gof :call os#file_manager()<CR>
" nnoremap gx :call os#open_url(expand('<cWORD>'))<CR>


nnoremap <expr> <leader>sa printf(":saveas %s%s",
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
command! BwipeHidden call win#delete_buffers()

" Open vim configs
command! Init :silent only
            \<bar>:exe printf("e  %s/plugin/mappings.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("bo vs %s/plugin/pack_list.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("bo vs %s/plugin/pack_setup.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("bo vs %s/after/plugin/setup.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("bo vs %s/vimrc", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:1wincmd w

" Open docs folder
command! Docs :exe printf('e %s/docs', empty($DOCSHOME)?expand('~'):expand($DOCSHOME))

" Open vim config folder
command! VimConfigs :exe printf('e %s', fnamemodify($MYVIMRC, ":p:h"))

" remove trailing spaces
command! RemoveTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
            \:exe 'normal! ``'<bar>
            \:echo 'Remove trailing spaces and ^Ms.'


command! -range FixText <line1>,<line2>call text#fix()

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
    let fullpaths = split(globpath("~/.vimdata/sessions/", a:A."*"), "\n")
    return map(fullpaths, {k,v -> fnamemodify(v, ":t")})
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
