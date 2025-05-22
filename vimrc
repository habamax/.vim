vim9script

filetype plugin indent on
syntax on

set hidden confirm
set ttimeout ttimeoutlen=25
set belloff=all shortmess+=Ic
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set ruler display=lastline smoothscroll
set hlsearch incsearch ignorecase smartcase
set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags
set number relativenumber cursorline cursorlineopt=number signcolumn=number
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=fold:\ ,vert:│,tpl_vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set fileformat=unix fileformats=unix,dos
set sidescroll=1 sidescrolloff=3
set nrformats=bin,hex,unsigned
set nospell spelllang=en,ru
set diffopt+=algorithm:histogram,indent-heuristic,inline:char,linematch:50
set sessionoptions=buffers,curdir,tabpages,winsize
set viminfo='200,<500,s32
set mouse=a

&directory = $'{$MYVIMDIR}.data/swap/'
&backupdir = $'{$MYVIMDIR}.data/backup//'
&undodir = $'{$MYVIMDIR}.data/undo//'
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile
