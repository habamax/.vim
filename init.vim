" Author: Maxim Kim <habamax@gmail.com>

"" Must have {{{1

" Make vim speak English
language messages en_US.UTF-8

autocmd!

filetype plugin indent on

syntax enable

set hidden
set browsedir=buffer

let mapleader = "\<Space>"

set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix


"" UI {{{1
set shortmess+=Ic
set winaltkeys=no
set guioptions=cM
set showtabline=1
set cmdheight=1
set nonumber norelativenumber
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

set confirm

set conceallevel=0

"" Unicode chars
" set listchars=tab:→\ ,eol:┘,trail:·
" let &showbreak='└ '
set listchars=tab:→\ ,eol:↲,trail:·
let &showbreak='↳ '
set fillchars=fold:\ ,vert:│

" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" turn off beeping... oldfashioned way
" set visualbell
" au! GuiEnter * set t_vb=
" set t_vb=
set belloff=all

set completeopt=menuone
if !has('nvim') && v:version > 802 | set completeopt+=popup | endif


"" Text {{{1
set tabstop=8 softtabstop=-1 shiftwidth=4 expandtab smarttab
set shiftround
set autoindent

set nohlsearch incsearch
set ignorecase smartcase

set nowrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
set virtualedit=block
set formatoptions=cqjl
set textwidth=78

set spelllang=ru,en
set nospell

set commentstring=


"" Misc {{{1

" neovim loads clipboard.vim at startup having this option set
" and it makes startup slower.
" vim doesn' have this problem
if !has("nvim") 
    set clipboard=unnamed
endif

set sessionoptions=buffers,curdir,tabpages,winsize

" ripgrep as grepprg
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if has('mouse')
    set mouse=a
endif

" vim and terminals have hard time processing ESCs (laaaag)
" this helps a lot
set ttimeout
set ttimeoutlen=10


" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" better encryption
if has('crypt-blowfish2')
    set cryptmethod=blowfish2
endif

" remove default 'octal'.
" good for C-a, C-x wrt 007 and other octal like numbers
set nrformats=bin,hex


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
    let c='A'
    while c <= 'Z'
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

" general mapping to be used for different filetypes
nnoremap <leader>m <nop>

nnoremap <BS> <C-^>

" Capitalize word
nnoremap <silent> <M-c> :call text#capitalize_word()<CR>
" UPPERCASE word
nnoremap <silent> <M-u> :call text#uppercase_word()<CR>
" lowercase word
nnoremap <silent> <M-U> :call text#lowercase_word()<CR>
" Capitalize word in insert mode
inoremap <silent> <M-c> <ESC>:call text#capitalize_word(v:true)<CR>
" UPPERCASE word in insert mode
inoremap <silent> <M-u> <ESC>:call text#uppercase_word(v:true)<CR>
" lowercase word in insert mode
inoremap <silent> <M-U> <ESC>:call text#lowercase_word(v:true)<CR>


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

nnoremap <M-f> <C-f>
xnoremap <M-f> <C-f>
nnoremap <M-b> <C-b>
xnoremap <M-b> <C-b>

" inoremap <M-b> <C-left>
" inoremap <M-f> <C-right>
" inoremap <M-a> <Home>
" inoremap <M-e> <End>
" inoremap <M-w> <C-w>
" inoremap <M-d> <Del>

" cnoremap <M-b> <C-left>
" cnoremap <M-f> <C-right>
" cnoremap <M-a> <Home>
" cnoremap <M-e> <End>
" cnoremap <M-w> <C-w>
" cnoremap <M-d> <Del>
" cnoremap <M-p> <C-p>
" cnoremap <M-n> <C-n>

"" Window mangament
" switch to previous window
tnoremap <M-o> <C-\><C-N><C-w>p
nnoremap <M-o> <C-w>p
inoremap <M-o> <C-\><C-N><C-w>p

" close window
tnoremap <M-q> <C-\><C-N><C-w>q
nnoremap <M-q> <C-w>q
inoremap <M-q> <C-\><C-N><C-w>q

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
    exe printf("nnoremap <M-%s> %s<C-w>w", wnr, wnr)
endfor


nnoremap <silent> <F3> :echo win#layout_save()<CR>
nnoremap <silent> <F4> :echo win#layout_restore()<CR>
nnoremap <silent> <F5> :echo win#layout_toggle()<CR>


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

nnoremap Y y$

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <M-s> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u


" just one space on the line, preserving indent
nnoremap <leader><leader><leader> :FixText<CR>

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

" edit init file (vimrc) -- nvim's init.vim sources vimrc
nnoremap <silent> <Leader>evi :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/init.vim"<CR>
" Close other files, open 4 main vim configs
nnoremap <silent> <Leader>evv :Init<CR>


" Directory ~/docs 
nnoremap <silent> <Leader>dd :Docs<CR>
" Directory ~/vimfiles or ~/.vim 
nnoremap <silent> <Leader>dv :VimConfigs<CR>

" guard <Leader>d not to delete accidentally
nnoremap <silent> <Leader>d <nop>
nnoremap <silent> d<Leader> <nop>


"" g:HOME is in paths.vim
" edit global notes file
nnoremap <silent> <Leader>en :exe printf('e %s/docs/notes/notes.adoc', g:HOME)<CR>
" edit global current journal file
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

" highlight all occurrences of a term being searched/replaced
augroup hlsearch-incsearch
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Open (n)vim configs
command! Init :silent only
            \<bar>:exe printf("e %s/init.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/plugin_settings.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("sp %s/gvimrc", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:1wincmd w 
            \<bar>:exe printf("sp %s/plugins.vim", fnamemodify($MYVIMRC, ":p:h"))
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


augroup autosize_windows | au!
    au BufWinEnter,WinEnter * silent! call win#lens()
augroup end


"" Load Other Settings (plugins, colorscheme, etc) {{{1

" local machine settings, shouldn't be in the git repo
silent! source <sfile>:h/local.vim

source <sfile>:h/foldtext.vim

source <sfile>:h/paths.vim

source <sfile>:h/russian.vim

source <sfile>:h/statusline.vim

source <sfile>:h/tabline.vim

source <sfile>:h/abbreviations.vim

source <sfile>:h/colorscheme_setup.vim

if v:version >= 801 || has('nvim')
    source <sfile>:h/plugin_settings.vim
    source <sfile>:h/plugins.vim
endif
