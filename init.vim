" Author: Maxim Kim <habamax@gmail.com>

"" Must-have {{{1
language messages en_US.UTF-8

filetype plugin indent on
syntax on

set hidden
set encoding=utf8 fileencoding=utf8 fileformat=unix fileformats=unix,dos
set tabstop=8 softtabstop=-1 shiftwidth=4 expandtab smarttab shiftround
set nohlsearch incsearch ignorecase
set autoindent
set virtualedit=block
set ttimeout ttimeoutlen=10
set belloff=all

"" Nice-to-have {{{1
set shortmess+=Ic
set lazyredraw
set splitbelow splitright
set scrolloff=2 sidescrolloff=0
set display=truncate
set completeopt=menuone
set list listchars=tab:›\ ,extends:→,precedes:←,nbsp:·,trail:·
set breakindent breakindentopt=sbr showbreak=╰
set nowrap
set nojoinspaces
set formatoptions=cqjl
set backspace=indent,eol,start
set confirm
set nospell spelllang=ru,en
set commentstring=
set nrformats=bin,hex
set sessionoptions=buffers,curdir,tabpages,winsize

set wildchar=<Tab> wildmenu wildmode=full
" to use in cnoremaps
set wildcharm=<C-z>
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" ripgrep as grepprg
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if has('mouse') | set mouse=a | endif

if !has('nvim') && has('patch-8.1.360')
    set diffopt+=vertical,algorithm:patience
else
    set diffopt+=vertical
endif

if has('nvim') | set inccommand=nosplit | endif


"" Mappings {{{1

" Fix Alt mappings for terminal vim
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
if !has('nvim') && !has('gui_running') && !has('win32')
    let c='a'
    while c <= 'z'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
    let c='0'
    while c <= '9'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
endif

let mapleader = "\<Space>"

" smooth searching
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

nnoremap <leader>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" guards
nnoremap <leader>m <nop>
nnoremap <leader>o <nop>
nnoremap <Leader>d <nop>
nnoremap d<Leader> <nop>

nnoremap <BS> <C-^>
" kill-all buffers except current one
nnoremap <M-BS> :%bd<CR><C-^>:bd#<CR>

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
nnoremap <leader>wo <C-w>o
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

nnoremap <silent> <F11> :echo win#layout_save()<CR>
nnoremap <silent> <F12> :echo win#layout_restore()<CR>

"" indent text object
onoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
onoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
xnoremap <silent>ii <ESC>:call text#obj_indent(v:true)<CR><ESC>gv
xnoremap <silent>ai <ESC>:call text#obj_indent(v:false)<CR><ESC>gv

"" number text object
func! s:number()
    call search('\d\([^0-9\.]\|$\)', 'cW')
    normal v
    call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunc
xnoremap in :<C-u>call <SID>number()<CR>
onoremap in :<C-u>normal vin<CR>


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

" edit init file (vimrc) -- nvim's init.vim sources vimrc
nnoremap <silent> <Leader>ei :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/init.vim"<CR>


" Directory ~/docs
nnoremap <silent> <Leader>dd :Docs<CR>
" Directory ~/vimfiles or ~/.vim
nnoremap <silent> <Leader>dv :VimConfigs<CR>



"" g:HOME is in paths.vim
" edit global todo file
nnoremap <silent> <Leader>et :exe printf('e %s/docs/todo.adoc', g:HOME)<CR>
" edit global journal file
nnoremap <silent> <Leader>ej :exe printf('e %s/docs/journal/2020.adoc', g:HOME)<CR>

" scroll other window
nnoremap <silent> <M-F> :call win#scroll_other(1)<CR>
nnoremap <silent> <M-B> :call win#scroll_other(0)<CR>

nnoremap <silent> gof :call os#file_manager()<CR>
nnoremap gx :call os#open_url(expand('<cWORD>'))<CR>

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

" Open (n)vim configs
command! Init :silent only
            \<bar>:exe printf("e %s/init.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/pack_list.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/pack_setup.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/after/plugin/init.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:1wincmd w

" Open docs folder
command! Docs :exe printf('e %s/docs', g:HOME)

" Open vim config folder
command! VimConfigs :exe printf('e %s', fnamemodify($MYVIMRC, ":p:h"))

" remove trailing spaces
command! RemoveTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
            \:exe 'normal! ``'<bar>
            \:echo 'Remove trailing spaces and ^Ms.'


command! -range FixText <line1>,<line2>call text#fix()

" Continuous buffers.
" 1. Vertically split window
" 2. Offset it one screen
" 3. Scrollbind
command! ContinueInSplit
            \   exe "normal zR"
            \ | set noscrollbind
            \ | vsplit
            \ | exe "normal \<c-f>"
            \ | set scrollbind
            \ | wincmd p
            \ | set scrollbind

command! -range=% PasteVP call share#vpaste(<line1>, <line2>)
command! -range=% PasteDP call share#dpaste(<line1>, <line2>)
command! -range=% PasteIX call share#ix(<line1>, <line2>)
command! -range=% PasteCL call share#clbin(<line1>, <line2>)

command! CD lcd %:p:h

" Not for Windows
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


if exists('##TextYankPost') && has('nvim')
    augroup hi_yanktext | au!
        au TextYankPost * silent! lua require'vim.highlight'.on_yank('Search', 200)
    augroup end
endif


"" Plugins, colors, etc {{{1

" local machine settings, shouldn't be in the git repo
silent! source <sfile>:h/local.vim

source <sfile>:h/foldtext.vim

source <sfile>:h/paths.vim

source <sfile>:h/russian.vim

source <sfile>:h/statusline.vim

source <sfile>:h/tabline.vim

source <sfile>:h/abbreviations.vim

source <sfile>:h/color_setup.vim

if v:version >= 801 || has('nvim')
    source <sfile>:h/pack_setup.vim
    source <sfile>:h/pack_list.vim
endif
