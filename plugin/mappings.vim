" Non Plugin Mappings

" Essential for my vimscripting
" run selected vimscript
xnoremap <silent> <space>v y:@"<cr>
" run vimscript line
nmap <space>vv V<space>v
" run operator
func! s:viml(type = '')
    if a:type == ''
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
    @"
endfunc
nnoremap <silent> <expr> <space>v <SID>viml()

" localize it too
nmap <space>мм <space>vv
xmap <silent> <space>м <space>v
nmap <space>м <space>v


let maplocalleader = "\<space>"

" enhance search, only if wildcharm is set to <C-z>
if &wildcharm == 26
    cnoremap <expr> <Tab>   getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"
    cnoremap <expr> <S-Tab> getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"
endif


" Buffers: overridden by vim-select if exists
nnoremap <space>b :b<space><C-D>

nnoremap <space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Manual folding
nnoremap zf <cmd>setl fdm&<CR>zf
xnoremap zf <cmd>setl fdm&<CR>zf


" Toggles
nnoremap <silent> yoh :set hlsearch! hlsearch?<CR>
nnoremap <silent> yow :set wrap! wrap?<CR>
nnoremap <silent> yon :set number! number?<CR>
nnoremap <silent> yor :set relativenumber! relativenumber?<CR>
nnoremap <silent> yol :set list! list?<CR>
nnoremap <silent> yos :set spell! spell?<CR>
nnoremap <silent> yoc :set cursorline! cursorline?<CR>
nnoremap <expr> yod (&diff ? ":diffoff" : ":diffthis").."<CR>"
nnoremap <expr> yob ':colo ' .. (get(g:, 'colors_name', '') == 'saturnite' ? "freyeday" : "saturnite") .. "<CR>"
" nnoremap <expr> yob ':set bg='..(&bg=='dark' ? "light" : "dark").."<CR>"


" UPPERCASE word in insert mode
inoremap <silent> <C-space>u <ESC>gUiw`]a
" lowercase word in insert mode
inoremap <silent> <C-space>l <ESC>guiw`]a


" Window management
nnoremap <silent> <C-w>o :call win#zoom_toggle()<CR>
nmap <C-w><C-o> <C-w>o
nnoremap <silent> <C-w><space> :echo win#layout_toggle()<CR>
noremap <silent> <BS> <cmd>exe "wincmd " .. ((winnr('#') ?? winnr()) == winnr() ? 'w' : 'p')<CR>
nmap <silent> <C-w><C-p> <BS>
nmap <silent> <C-w>p <BS>
nnoremap <silent> <C-w><BS> :call win#lens_toggle()<CR>


" 24 simple text objects
" ----------------------
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
    execute 'xnoremap <silent> i' .. char .. ' :<C-u>call text#obj("' .. char .. '", 1)<CR>'
    execute 'xnoremap <silent> a' .. char .. ' :<C-u>call text#obj("' .. char .. '", 0)<CR>'
    execute 'onoremap <silent> i' .. char .. ' :normal vi' .. char .. '<CR>'
    execute 'onoremap <silent> a' .. char .. ' :normal va' .. char .. '<CR>'
endfor

" indent text object
onoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
onoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
xnoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
xnoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>

" number text object
func! s:number_textobj()
    let rx_num = '\d\+\(\.\d\+\)*'
    if search(rx_num, 'ceW')
        normal v
        call search(rx_num, 'bcW')
    endif
endfunc
xnoremap <silent> in :<C-u>call <SID>number_textobj()<CR>
onoremap in :<C-u>normal vin<CR>


" date text object
xnoremap <silent> id :<C-u>call text#date_textobj(1)<CR>
onoremap id :<C-u>normal vid<CR>
xnoremap <silent> ad :<C-u>call text#date_textobj(0)<CR>
onoremap ad :<C-u>normal vad<CR>


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u

" Fix text (remove double spaces, hanging spaces, etc)
nnoremap <space><space><space> :TextFixSpaces<CR>
xnoremap <space><space><space> :TextFixSpaces<CR>

" Syntax group names under cursor
nnoremap <space>ts :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')))<CR>

" Paste over selected text keeping initial yank
" xnoremap <expr> p 'pgv"'.v:register.'y`>'
" xnoremap <expr> P 'Pgv"'.v:register.'y`>'

nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

nnoremap <silent> <space>u <nop>
nnoremap <silent> <space>u- :call text#underline(['-', '=', '~', '^', '+'])<CR>
nnoremap <silent> <space>u= :call text#underline(['=', '-', '~', '^', '+'])<CR>
nnoremap <silent> <space>u~ :call text#underline(['~', '=', '-', '^', '+'])<CR>
nnoremap <silent> <space>u^ :call text#underline(['^', '=', '-', '~', '+'])<CR>
nnoremap <silent> <space>u+ :call text#underline(['+', '=', '-', '~', '^'])<CR>

" find visually selected text
xnoremap * y/<C-R>"<CR>

noremap <silent> <space>gi :call git#show_commit(v:count)<CR>
noremap <silent> <space>gb :call git#blame()<CR>

" edit global todo file
nnoremap <silent> <space>gt :exe printf('e %s/todo.adoc', expand($DOCS ?? '~/docs'))<CR>
" edit global journal file
nnoremap <silent> <space>gj :call journal#new()<CR>


nnoremap <silent> gof :call os#file_manager()<CR>
nnoremap got :TermBuffer<CR>


" Save as
nnoremap <expr> <space>FS printf(":saveas %s%s",
            \ expand("%:p"),
            \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))

" Rename (valid if vim-eunuch is installed)
nnoremap <expr> <space>FR printf(":Move %s%s",
            \ expand("%:p"),
            \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))


" Sort operator
func! s:sort(type, ...)
    '[,']sort
endfunc
nmap <silent> gs :set opfunc=<SID>sort<CR>g@
xmap <silent> gs :sort<CR>


tnoremap <C-v> <C-w>""


" Template <+placeholders+> navigation
snoremap <BS> <space><BS>
func! s:placeholder_next(dir = 1) abort
    if search('<+.\{-}+>', a:dir ? "" : "b")
        exe "normal! va<o\<C-g>"
    endif
endfunc

func! s:placeholder_accept() abort
    if search('<+.\{-}+>', "c")
        exe 'normal! 2"_x'
        call search('+>', "c")
        exe 'normal! 2"_x'
        call s:placeholder_next()
    endif
endfunc

nnoremap <silent> <C-j> :<C-u>call <SID>placeholder_next()<CR>
inoremap <silent> <C-j> <C-\><C-o>:call <SID>placeholder_next()<CR>
snoremap <silent> <C-j> <ESC>:call <SID>placeholder_next()<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>placeholder_next(0)<CR>
snoremap <silent> <C-k> <ESC>:call <SID>placeholder_next(0)<CR>
snoremap <silent> <CR> <ESC>:call <SID>placeholder_accept()<CR>


" QuickFix
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]w :lnext<CR>
nnoremap <silent> ]W :llast<CR>
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> [W :lfirst<CR>


" Next/Prev change for diff mode
nnoremap <silent> ]x :call diff#next_change()<CR>
nnoremap <silent> [x :call diff#prev_change()<CR>

" Highlight/mark text
nnoremap <silent> <space>kk :call markit#mark()<CR>
xnoremap <silent> <space>kk <cmd>call markit#mark()<CR><ESC>
nnoremap <silent> <space>ku :call markit#unmark()<CR>
xnoremap <silent> <space>ku <cmd>call markit#unmark()<CR><ESC>
nnoremap <silent> <space>kU :call markit#unmark_all()<CR>
