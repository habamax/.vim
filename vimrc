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
set list listchars=tab:›\ ,extends:→,precedes:←,nbsp:·,trail:· fillchars=vert:│
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

silent! colorscheme bronzage
