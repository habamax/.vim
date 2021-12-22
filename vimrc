filetype plugin indent on
syntax on

set hidden confirm
set fileformat=unix fileformats=unix,dos
set nohlsearch incsearch ignorecase
set shiftwidth=4 softtabstop=-1 expandtab
set autoindent
set nostartofline virtualedit=block
set ttimeout ttimeoutlen=50
set belloff=all
set ruler
set signcolumn=number
set shortmess+=Ic
set lazyredraw display=lastline
set completeopt=menu,popup completepopup=highlight:Pmenu
set list listchars=tab:›\ ,extends:→,precedes:←,nbsp:·,trail:·
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak
set formatoptions=cqjl
set backspace=indent,eol,start
set nospell spelllang=ru,en
set commentstring=
set nrformats=bin,hex,unsigned
set foldmethod=indent foldlevelstart=1 foldminlines=2
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set wildmenu wildcharm=<C-z>
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200
set mouse=a ttymouse=sgr

if executable('rg') | set grepprg=rg\ --vimgrep grepformat=%f:%l:%c:%m | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Non Plugin Mappings

" run vimscript operator
func! s:viml(...)
    if a:0 == 0
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    let commands = {"line": "'[V']y", "char": "`[v`]y", "block": "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' . get(commands, a:1, '')
    @"
endfunc
nnoremap <silent> <expr> <space>v <SID>viml()
xnoremap <silent> <space>v y:@"<CR>
nmap <space>vv V<space>v

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

nnoremap <space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" manual folding
nnoremap zf <cmd>setl fdm&<CR>zf
xnoremap zf <cmd>setl fdm&<CR>zf

" toggles
nnoremap <silent> yoh :set hlsearch! hlsearch?<CR>
nnoremap <silent> yow :set wrap! wrap?<CR>
nnoremap <silent> yon :set number! number?<CR>
nnoremap <silent> yor :set relativenumber! relativenumber?<CR>
nnoremap <silent> yol :set list! list?<CR>
nnoremap <silent> yos :set spell! spell?<CR>
nnoremap <silent> yoc :set cursorline! cursorline?<CR>
nnoremap <expr> yod (&diff ? ":diffoff" : ":diffthis") . "<CR>"
nnoremap <expr> yob ':colo ' . (get(g:, 'colors_name', '') == 'bronzage' ? "sugarlily" : "bronzage") . "<CR>"

" window management
nnoremap <silent> <C-w>m :resize<bar>vert resize<CR>
nmap <C-w><C-m> <C-w>m
tmap <silent> <C-w>m <C-w>:resize<bar>vert resize<CR>
nnoremap <silent><expr> <C-j> winnr('$') > 1 ? "\<C-w>w" : ":bel vs +b#\<CR>"
nnoremap <silent><expr> <C-k> winnr('$') > 1 ? "\<C-w>W" : ":vs +b#\<CR>"
tnoremap <silent><expr> <C-j> winnr('$') > 1 ? "\<C-w>w" : "\<C-w>:bel vs +b#\<CR>"
tnoremap <silent><expr> <C-k> winnr('$') > 1 ? "\<C-w>W" : "\<C-w>:vs +b#\<CR>"
nnoremap <silent> <C-w><space> :echo win#layout_toggle()<CR>
nmap <silent> <C-w><C-space> <C-w><space>
nnoremap <silent> <C-w><BS> :call win#lens_toggle()<CR>

" buffers
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>
tnoremap <silent> <C-n> <cmd>:bn<CR>
tnoremap <silent> <C-p> <cmd>:bp<CR>

" 26 simple text objects
" ----------------------
" i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
" a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
    execute 'xnoremap <silent> i' . char . ' :<C-u>call text#obj("' . char . '", 1)<CR>'
    execute 'xnoremap <silent> a' . char . ' :<C-u>call text#obj("' . char . '", 0)<CR>'
    execute 'onoremap <silent> i' . char . ' :normal vi' . char . '<CR>'
    execute 'onoremap <silent> a' . char . ' :normal va' . char . '<CR>'
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
inoremap <C-l> <C-g>u<ESC>[s1z=gi<C-g>u

" syntax group names under cursor
nnoremap <space>ts :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')))<CR>

nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

nnoremap <silent> <space># :call text#underline('#')<CR>
nnoremap <silent> <space>* :call text#underline('*')<CR>
nnoremap <silent> <space>= :call text#underline('=')<CR>
nnoremap <silent> <space>- :call text#underline('-')<CR>
nnoremap <silent> <space>~ :call text#underline('~')<CR>
nnoremap <silent> <space>^ :call text#underline('^')<CR>
nnoremap <silent> <space>+ :call text#underline('+')<CR>
nnoremap <silent> <space>" :call text#underline('"')<CR>
nnoremap <silent> <space>` :call text#underline('`')<CR>

nnoremap <silent> <expr> gc comment#toggle()
xnoremap <silent> <expr> gc comment#toggle()
nnoremap <silent> <expr> gcc comment#toggle() . '_'

" find visually selected text
xnoremap * y/<C-R>"<CR>

nnoremap <silent> <space>gi :<C-u>call git#show_commit(v:count)<CR>
xnoremap <silent> <space>gi :call git#show_commit(v:count)<CR>
noremap <silent> <space>gb :call git#blame()<CR>

nnoremap go <nop>
" go to journal file
nnoremap <silent> goj :call journal#new()<CR>
" go to todo file
nnoremap <silent> got :exe printf('e %s/todo.txt', expand($DOCS ?? '~/docs'))<CR>
" go to *** file
nnoremap <silent> gop :exe printf('e %s/creds.txt', expand($DOCS ?? '~/docs'))<CR>
" go to current file in os file manager
nnoremap <silent> gof :call os#file_manager()<CR>

" save as
nnoremap <expr> <space>FS printf(":saveas %s%s",
      \ expand("%:p"),
      \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))

" rename (valid if vim-eunuch is installed)
nnoremap <expr> <space>FR printf(":Move %s%s",
      \ expand("%:p"),
      \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))

" 'array' sort operator
" const whatever = [   ->   const whatever = [
"     'bar',                    'acme',
"     'baz',                    'bar',
"     'foo',                    'baz',
"     'acme'                    'foo'
" ]                         ]
func! s:sort(...) range
    '[,']sort
    " add commas to every line
    '[,']s/[^,]$/&,/e
    " remove comma from the last line
    ']s/,$//e
endfunc
nmap <silent> gs :set opfunc=<SID>sort<CR>g@
xmap <silent> gs :sort <bar> s/[^,]$/&,/e <bar> '>s/,$//e<CR>

" gq wrapper that:
" - tries its best at keeping the cursor in place
" - tries to handle formatter errors
func! s:gq_format(...) abort
    if a:0 == 0
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    if a:1 == 'v'
        normal! gvgq
    else
        normal! '[v']gq
    endif
    if v:shell_error > 0
        silent undo
        redraw
        echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
    endif
    if exists("w:gqview")
        call winrestview(w:gqview)
        unlet w:gqview
    endif
endfunc
nnoremap <silent> gq :let w:gqview = winsaveview()<CR>:set opfunc=<SID>gq_format<CR>g@
nmap <silent> gqq gq_
xnoremap <silent> gq :<C-U>call <SID>gq_format('v')<CR>

tnoremap <C-v> <C-w>""

" QuickFix
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]w :lnext<CR>
nnoremap <silent> ]W :llast<CR>
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> [W :lfirst<CR>

" next/prev change for diff mode
nnoremap <silent> ]x :call diff#next_change()<CR>
nnoremap <silent> [x :call diff#prev_change()<CR>

" open URLs
nnoremap <silent> gx :call os#gx()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap & Backup & Undo

let &directory = expand('~/.vimdata/swap//')
let &backupdir = expand('~/.vimdata/backup//')
let &undodir = expand('~/.vimdata/undo//')
if !isdirectory(&undodir)   | call mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif

set backup
set undofile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands

augroup hlsearch | au!
    au CmdlineEnter /,\? :set hlsearch
    au CmdlineLeave /,\? :set nohlsearch
augroup end

augroup restore_pos | au!
    au BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          \ |   exe 'normal! g`"'
          \ | endif
augroup end

augroup win_autosize | au!
    au WinEnter * silent! call win#lens()
augroup end

if exists("$WSLENV")
    augroup WSLClip | au!
        au TextYankPost * if v:event.regname == '"' | call system("clip.exe ", v:event.regcontents) | endif
    augroup END
endif

augroup colors | au!
    au Colorscheme sugarlily hi Normal guibg=#daddda ctermbg=253
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands

" update packages
command! PlugUp call git#plug_update()

" wipe all hidden buffers
command! WipeHiddenBuffers call win#delete_buffers()

" remove trailing spaces
command! FixTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
      \ :exe 'normal! ``'<bar>
      \ :echo 'Remove trailing spaces and ^Ms.'

command! -range FixSpaces <line1>,<line2>call text#fix_spaces()

command! -range=% -nargs=? -complete=customlist,share#complete Share call share#paste(<q-args>, <line1>, <line2>)

command! GistSync call gist#sync()

command! CD lcd %:p:h

" save and load sessions
command! -nargs=1 -complete=customlist,<SID>sessionComplete S :mksession! ~/.vimdata/sessions/<args>
command! -nargs=1 -complete=customlist,<SID>sessionComplete L :%bd <bar> so ~/.vimdata/sessions/<args>
func! s:sessionComplete(A, L, P)
    let fullpaths = split(globpath("~/.vimdata/sessions/", "*"), "\n")
    let result = map(fullpaths, {k,v -> fnamemodify(v, ":t")})
    if empty(a:A)
        return result
    else
        return result->matchfuzzy(a:A)
    endif
endfunc

" write to a privileged file
if executable('sudo')
    command! W w !sudo tee "%" > /dev/null
endif

" open terminal with a cwd of a current buffer
command! Term :bo call term_start(&shell, {"cwd": expand("%:p:h"), "term_finish": "close"})

" redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 -complete=command -bar Redir silent call v#redir(<q-args>)

" Global command, inspired by romainl
" https://gist.github.com/romainl/f7e2e506dc4d7827004e4994f1be2df6
command! -bang -nargs=1 Global call setloclist(0, [], ' ',
      \ {'title': 'Global ' . <q-args>,
      \  'efm':   '%f:%l\ %m,%f:%l',
      \  'lines': execute('g<bang>/' . <q-args> . '/#')
      \           ->split('\n')
      \           ->map({_, val -> expand("%") . ":" . trim(val)})
      \ }) | lwindow

" helper command to use old built-in colorschemes
command! -nargs=1 -complete=color Colo exe "so $VIMRUNTIME/colors/" . <q-args> . ".vim"


if has("gui_running")
    silent! colorscheme sugarlily
else
    silent! colorscheme bronzage
endif
