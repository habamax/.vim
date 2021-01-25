language messages en_US.UTF-8

filetype plugin indent on
syntax on

set hidden
set encoding=utf8 fileencoding=utf8 fileformat=unix fileformats=unix,dos
set tabstop=8 softtabstop=-1 shiftwidth=4 expandtab smarttab shiftround
set nohlsearch incsearch ignorecase
set autoindent copyindent preserveindent
set virtualedit=block
set ttimeout ttimeoutlen=0
set belloff=all

set ruler laststatus=2
set signcolumn=number
set splitbelow splitright
set shortmess+=Ic
set scrolloff=5 sidescrolloff=5
set display=truncate
set completeopt=menuone,noselect
set list listchars=tab:›\ ,extends:→,precedes:←,nbsp:·,trail:·
set nowrap breakindent breakindentopt=sbr
set nojoinspaces
set formatoptions=cqjl
set backspace=indent,eol,start
set confirm
set nospell spelllang=ru,en
set commentstring=
set nrformats=bin,hex
set sessionoptions=buffers,curdir,tabpages,winsize
set foldmethod=indent nofoldenable
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set wildchar=<Tab> wildcharm=<C-z> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png
set history=200

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
