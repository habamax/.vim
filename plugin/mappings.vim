"" Non Plugin Mappings

"" OS clipboard yank and paste
noremap <space>y "+y
noremap <space>p "+p
noremap <space>P "+P

noremap <space>0 "0p
noremap <space>) "0P

"" tab to cycle search candidates
cnoremap <expr> <Tab>   getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"

"" Find file/buffer
"" Overriden by vim-select if exists
nnoremap <space>ff :find<space>
nnoremap <space>fe :e<space><C-D>
nnoremap <space>b :b<space><C-D>

nnoremap <space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

nnoremap <BS> <C-^>

"" UPPERCASE WORD
nnoremap <silent> <M-u> gUiww
"" lowercase WORD
nnoremap <silent> <M-U> guiww

"" UPPERCASE word in insert mode
inoremap <silent> <M-u> <ESC>gUiw`]a
"" lowercase word in insert mode
inoremap <silent> <M-U> <ESC>guiw`]a


"" Move line up/down
nnoremap <silent> <M-p> :<C-u>silent! exe "move-2"<CR>==
nnoremap <silent> <M-n> :<C-u>silent! exe "move+1"<CR>==
inoremap <silent> <M-p> <ESC>:<C-u>silent! exe "move-2"<CR>==gi
inoremap <silent> <M-n> <ESC>:<C-u>silent! exe "move+1"<CR>==gi
"" Move selected lines up/down
xnoremap <silent> <M-p> :<C-u>silent! exe "'<,'>move-2"<CR>gv=gv
xnoremap <silent> <M-n> :<C-u>silent! exe "'<,'>move'>+"<CR>gv=gv

nnoremap <M-f> <C-d>
xnoremap <M-f> <C-d>
nnoremap <M-b> <C-u>
xnoremap <M-b> <C-u>

cnoremap <M-f> <C-right>
cnoremap <M-b> <C-left>

"" Window management
" Switch windows
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l

nnoremap <silent><space>c :b#<bar>bd#<cr>
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


"" 24 simple text objects
"" ----------------------
"" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
"" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
    execute 'xnoremap <silent> i' .. char .. ' :<C-u>call text#simple_textobj("'..char..'", 1)<CR>'
    execute 'xnoremap <silent> a' .. char .. ' :<C-u>call text#simple_textobj("'..char..'", 0)<CR>'
    execute 'onoremap <silent> i' .. char .. ' :normal vi' . char . '<CR>'
    execute 'onoremap <silent> a' .. char .. ' :normal va' . char . '<CR>'
endfor

"" indent text object
onoremap <silent>ii :<C-u>call text#indent_textobj(v:true)<CR>
onoremap <silent>ai :<C-u>call text#indent_textobj(v:false)<CR>
xnoremap <silent>ii :<C-u>call text#indent_textobj(v:true)<CR>
xnoremap <silent>ai :<C-u>call text#indent_textobj(v:false)<CR>

"" number text object
func! s:number_textobj()
    let rx_num = '\d\+\(\.\d\+\)*'
    if search(rx_num, 'ceW')
        normal v
        call search(rx_num, 'bcW')
    endif
endfunc
xnoremap <silent> in :<C-u>call <SID>number_textobj()<CR>
onoremap in :<C-u>normal vin<CR>


"" date text object
xnoremap <silent> id :<C-u>call text#date_textobj(1)<CR>
onoremap id :<C-u>normal vid<CR>
xnoremap <silent> ad :<C-u>call text#date_textobj(0)<CR>
onoremap ad :<C-u>normal vad<CR>


"" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
"" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"" spell correction for the first suggested
"" https://castel.dev/post/lecture-notes-1/
inoremap <M-s> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u

nnoremap <space>t<space> i<space><right><space><ESC>h

"" Fix text (remove double spaces, hanging spaces, etc)
nnoremap <space>tf :TextFixSpaces<CR>
xnoremap <space>tf :TextFixSpaces<CR>

"" Syntax group names under cursor
nnoremap <space>ts :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')))<CR>

"" now it is possible to paste many times over selected text
" xnoremap <expr> p 'pgv"'.v:register.'y`>'
" xnoremap <expr> P 'Pgv"'.v:register.'y`>'

"" shift right and left
xnoremap > >gv
xnoremap < <gv

"" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

nnoremap <silent> <space>t- :call text#underline(['-', '=', '~', '^', '+'])<CR>
nnoremap <silent> <space>t= :call text#underline(['=', '-', '~', '^', '+'])<CR>
nnoremap <silent> <space>t~ :call text#underline(['~', '=', '-', '^', '+'])<CR>
nnoremap <silent> <space>t^ :call text#underline(['^', '=', '-', '~', '+'])<CR>
nnoremap <silent> <space>t+ :call text#underline(['+', '=', '-', '~', '^'])<CR>

nnoremap <silent> <space><space>t- o<home><ESC>78i-<ESC>
nnoremap <silent> <space><space>t= o<home><ESC>78i=<ESC>

"" find visually selected text
vnoremap * y/<C-R>"<CR>

noremap <silent> <space>gi :call git#show_commit(v:count)<CR>
noremap <silent> <space>gb :call git#blame()<CR>

"" edit global todo file
nnoremap <silent> <space>et :exe printf('e %s/docs/todo.adoc', empty($DOCSHOME)?expand('~'):expand($DOCSHOME))<CR>
"" edit global journal file
nnoremap <silent> <space>ej :call journal#new()<CR>
"" edit new file
nnoremap <space>en :enew<CR>


"" scroll other window
nnoremap <silent> <M-F> :call win#scroll_other(1)<CR>
nnoremap <silent> <M-B> :call win#scroll_other(0)<CR>

nnoremap <silent> gof :call os#file_manager()<CR>


"" Save as
nnoremap <expr> <space>S printf(":saveas %s%s",
            \ expand("%:p"),
            \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))


"" Sort operator
func! Sort(type, ...)
    '[,']sort
endfunc
nmap <silent> gs :set opfunc=Sort<CR>g@
vmap <silent> gs :sort<CR>

nnoremap got :TermBuffer<CR>

tnoremap <Esc> <C-w>N
tnoremap <C-v> <C-w>""
