vim9script

filetype plugin indent on
syntax on

set hidden confirm
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set ttimeout ttimeoutlen=25
set ruler
set belloff=all shortmess+=Ic
set display=lastline smoothscroll
set hlsearch incsearch ignorecase smartcase
set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags
set completeopt=menu,popup,fuzzy completepopup=highlight:Pmenu
set number relativenumber cursorline cursorlineopt=number signcolumn=number
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=fold:\ ,vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set fileformat=unix fileformats=unix,dos
set sidescroll=1 sidescrolloff=3
set nrformats=bin,hex,unsigned
set nospell spelllang=en,ru
set diffopt+=vertical,algorithm:histogram,indent-heuristic,linematch:50
set sessionoptions=buffers,curdir,tabpages,winsize
set viminfo='200,<500,s32

if executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
elseif executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

&directory = $'{$MYVIMDIR}/.data/swap/'
&backupdir = $'{$MYVIMDIR}/.data/backup//'
&undodir = $'{$MYVIMDIR}/.data/undo//'
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile
