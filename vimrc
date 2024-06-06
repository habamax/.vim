vim9script

filetype plugin indent on
syntax on

set hidden confirm
set shiftwidth=4 softtabstop=-1 expandtab
set ttimeout ttimeoutlen=25
set autoindent
set hlsearch incsearch ignorecase
set wildmenu wildoptions=pum,fuzzy pumheight=20
set number relativenumber cursorline cursorlineopt=number
set backspace=indent,eol,start
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set fileformat=unix fileformats=unix,dos
set display=lastline smoothscroll
set sidescroll=1 sidescrolloff=3
set virtualedit=block
set nostartofline
set belloff=all
set ruler
set signcolumn=number
set shortmess+=Ic
set completeopt=menu,popup completepopup=highlight:Pmenu
set list listchars=tab:›\ ,nbsp:․,trail:·,extends:…,precedes:…
set fillchars=vert:│
set nospell spelllang=en,ru
set nrformats=bin,hex,unsigned
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200
set viminfo='200,<500,s32
set mouse=a
set path=.,,
set clipboard=unnamedplus

if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

g:vimdata = $'{$APPDATA ?? expand("~/.config")}/vim-data'
if !isdirectory(g:vimdata) | mkdir(g:vimdata, "p") | endif

&directory = $'{g:vimdata}/swap/'
&backupdir = $'{g:vimdata}/backup//'
&undodir = $'{g:vimdata}/undo//'
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile
