" Author: Maxim Kim <habamax@gmail.com>

"" Must have {{{1

" Everything will be in English
language messages en_US.UTF-8

filetype plugin indent on

" Clean all autocommands
autocmd!

syntax enable

set hidden
set confirm
set browsedir=buffer

let mapleader = "\<Space>"

" Vim and terminals have hard time processing ESCs (laaaag)
" This helps a lot
set ttimeout
set ttimeoutlen=100

"" Encoding and fileformat {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

"" UI {{{1
if has('mouse')
    set mouse=a
endif

set shortmess+=Ic
set winaltkeys=no
set guioptions=cMe
set showtabline=1
set cmdheight=1
set nonumber norelativenumber
set winminwidth=10 winheight=5 winminheight=5
set lazyredraw
set splitbelow
set splitright
set helpheight=0
if !has('nvim') && has('patch-8.1.360')
    set diffopt=internal,filler,vertical,algorithm:patience
else
    set diffopt=filler,vertical
endif

set scrolloff=2 sidescrolloff=0
set display+=lastline
set tabpagemax=50
set showmode

set conceallevel=0


"" Unicode chars
set listchars=tab:→\ ,eol:┘,trail:·
let &showbreak='└ '
set fillchars=fold:\ ,vert:│


" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" turn off beeping... oldfashioned way
" set visualbell
" au! GuiEnter * set t_vb=
" set t_vb=
set belloff=all

"" Text {{{1
set tabstop=8 softtabstop=-1 shiftwidth=4 expandtab smarttab
set shiftround
set autoindent

set nohlsearch incsearch ignorecase
" highlight all occurrences of a term being searched/replaced
augroup hlsearch-incsearch
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

set nowrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
set virtualedit=block
set formatoptions=cqjl
set textwidth=78

set completeopt=menuone
if !has('nvim') && v:version > 802 | set completeopt+=popup | endif

set spelllang=ru,en
set nospell

set clipboard=unnamed

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]


"" Encryption {{{1
if has('crypt-blowfish2')
    set cryptmethod=blowfish2
endif

"" Mappings {{{1

" remove default 'octal'.
" good for C-a, C-x wrt 007 and other octal like numbers
set nrformats=bin,hex

" Capitalize word
nnoremap <A-c> :call text#capitalize_word()<CR>
" UPPERCASE word
nnoremap <A-u> :call text#uppercase_word()<CR>
" lowercase word
nnoremap <A-l> :call text#lowercase_word()<CR>
" Capitalize word in insert mode
inoremap <A-c> <ESC>:call text#capitalize_word()<CR>a
" UPPERCASE word in insert mode
inoremap <A-u> <ESC>:call text#uppercase_word()<CR>a
" lowercase word in insert mode
inoremap <A-l> <ESC>:call text#lowercase_word()<CR>a

" Move line up/down
nnoremap <silent> <C-k> :<C-u>silent! exe "move-2"<CR>==
nnoremap <silent> <C-j> :<C-u>silent! exe "move+1"<CR>==
" Move selected lines up/down
xnoremap <silent> <C-k> :<C-u>silent! exe "'<,'>move-2"<CR>gv=gv
xnoremap <silent> <C-j> :<C-u>silent! exe "'<,'>move'>+"<CR>gv=gv

" goto window
nnoremap <space>1 1<C-w>w
nnoremap <space>2 2<C-w>w
nnoremap <space>3 3<C-w>w
nnoremap <space>4 4<C-w>w
nnoremap <space>5 5<C-w>w
nnoremap <space>6 6<C-w>w
nnoremap <space>7 7<C-w>w
nnoremap <space>8 8<C-w>w
nnoremap <space>9 9<C-w>w

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u

" just one space on the line, preserving indent
noremap <leader><leader><leader> :FixText<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" " change current word (like ciw) but repeatable with dot . for the same next
" " word
" nnoremap <silent> c* :let @/=expand('<cword>')<cr>cgn

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

" edit init file (vimrc) -- nvim's init.vim sources vimrc
nnoremap <silent> <Leader>evi :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/vimrc"<CR>
nmap <Leader>умш <Leader>evi
" edit gvim init file (gvimrc) -- nvim doesn't know about $GVIMRC and it's
" ginit.vim sources gvimrc
nnoremap <silent> <Leader>evg :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/gvimrc"<CR>
nmap <Leader>умп <Leader>evg
" edit plugins settings file 
nnoremap <silent> <Leader>evs :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/plugin_settings.vim"<CR>
nmap <Leader>умы <Leader>evs
" edit plugins list file
nnoremap <silent> <Leader>evp :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/plugins.vim"<CR>
nmap <Leader>умз <Leader>evp

"" g:HOME is in paths.vim
" edit global notes file
nnoremap <silent> <Leader>en :exe printf('e %s/docs/notes/notes.adoc', g:HOME)<CR>
nmap <Leader>ут <Leader>en
" edit global current journal file
nnoremap <silent> <Leader>ej :exe printf('e %s/docs/journal/2020.adoc', g:HOME)<CR>
nmap <Leader>уо <Leader>ej

" built-in terminal
tnoremap <esc> <C-\><C-n>

" scroll other window
nnoremap <silent> <C-Space> :call win#scroll_other(1)<CR>
nnoremap <silent> <C-S-Space> :call win#scroll_other(0)<CR>

" open explorer where current file is located
nnoremap <leader>oe :call os#show_file()<CR>
nnoremap gx :call os#open_url(expand('<cWORD>'))<CR>

" Sort operator
func! Sort(type, ...)
    '[,']sort
endfunc
nmap <silent> gs :set opfunc=Sort<CR>g@
vmap <silent> gs :sort<CR>


"" Commands (and Autocommands) {{{1

" Open (n)vim config
command! Vimrc :only
            \<bar>:exe printf("e %s/vimrc", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/plugin_settings.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/gvimrc", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:1wincmd w 

" Open docs folder
command! Docs :exe printf('e %s/docs', g:HOME)

" remove trailing spaces
command! RemoveTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
            \:exe 'normal ``'<bar>
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


command! CD lcd %:p:h

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis

" Not for Windows
" Write to a privileged file
if has("unix") || has("osxdarwin")
    command! W w !sudo tee "%" > /dev/null
endif

augroup restore_last_cursor_position | autocmd!
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup END

func! SetDefaultFiletype()
    if @% == "" && &filetype == ""
        setfiletype txt
    endif
endfunc
augroup default_filetype
    autocmd!
    autocmd BufEnter * call SetDefaultFiletype()
augroup END

"" Grepprg {{{1
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

"" Load Other Settings (plugins, colorscheme, etc) {{{1
silent! source <sfile>:h/foldtext.vim

silent! source <sfile>:h/paths.vim

silent! source <sfile>:h/russian.vim

silent! source <sfile>:h/statusline.vim

silent! source <sfile>:h/abbreviations.vim

silent! source <sfile>:h/colorscheme_setup.vim

if v:version >= 801 || has('nvim')
    source <sfile>:h/plugin_settings.vim
    source <sfile>:h/plugins.vim
endif
