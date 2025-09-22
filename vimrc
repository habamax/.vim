filetype plugin indent on
syntax on

set hidden confirm
set ttimeout ttimeoutlen=25
set belloff=all shortmess+=IcC
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set ruler display=lastline smoothscroll
set hlsearch incsearch ignorecase smartcase infercase
set number relativenumber cursorline cursorlineopt=number signcolumn=number
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=fold:\ ,foldsep:┆,vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set switchbuf=useopen
set fileformat=unix fileformats=unix,dos
set sidescroll=1 sidescrolloff=3
set nrformats=bin,hex,unsigned
set sessionoptions=buffers,curdir,tabpages,winsize
set nospell spelllang=en,ru
set diffopt+=algorithm:histogram,linematch:50
set completeopt=menuone,popup,fuzzy completepopup=highlight:Pmenu
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,t^5
set complete+=Fcompletor#Abbrev^3,Fcompletor#Register^5
set complete^=Fcompletor#Lsp^10
set autocomplete
set mouse=a
