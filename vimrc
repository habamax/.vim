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
set completeopt=popup,fuzzy completepopup=highlight:Pmenu
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,u^3,t^5,i^5
set complete+=Fcompletor#Abbrev^3
set complete+=Fcompletor#Register^5
set complete^=Fcompletor#Lsp^10
set autocomplete
set mouse=a
