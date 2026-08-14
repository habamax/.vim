filetype plugin indent on
syntax on

set hidden confirm
set ttimeout ttimeoutlen=25
set belloff=all shortmess+=IcC
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set display=lastline smoothscroll sidescroll=1 sidescrolloff=3
set hlsearch incsearch ignorecase smartcase
set number cursorline cursorlineopt=number signcolumn=number
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=vert:│,trunc:…
set virtualedit=block nostartofline
set switchbuf=useopen
set fileformat=unix fileformats=unix,dos
set nrformats=bin,hex,unsigned
set diffopt+=hiddenoff,algorithm:histogram,linematch:100
set completeopt=menu,fuzzy
set pumopt=height:15
set autocomplete complete=o,.,w,Fcomplete#Path,Fcomplete#Reg
set termwinscroll=40000
set sessionoptions=buffers,curdir,tabpages,winsize
set nospell spelllang=en,ru
set mouse=a
