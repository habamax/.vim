filetype plugin indent on
syntax on

set hidden confirm
set ttimeout ttimeoutlen=25
set belloff=all shortmess+=IcC
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set display=lastline smoothscroll sidescroll=1 sidescrolloff=3
set hlsearch incsearch ignorecase smartcase
set number relativenumber cursorline cursorlineopt=number signcolumn=number
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=fold:\ ,vert:│
set virtualedit=block nostartofline
set switchbuf=useopen
set fileformat=unix fileformats=unix,dos
set nrformats=bin,hex,unsigned
set diffopt+=algorithm:histogram,linematch:50
set completeopt=menu,popup,fuzzy completepopup=highlight:Pmenu pumborder=round
set autocomplete complete=o^10,.^10,w^5,b^5,u^3,t^3,Fcompletor#Abbrev^3
set completefuzzycollect=keyword
set sessionoptions=buffers,curdir,tabpages,winsize
set nospell spelllang=en,ru
set mouse=a
