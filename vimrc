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
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:…
set fillchars=fold:\ ,vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set fileformat=unix fileformats=unix,dos
set sidescroll=1 sidescrolloff=3
set nrformats=bin,hex,unsigned
set nospell spelllang=en,ru
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200
set viminfo='200,<500,s32
set mouse=a
set path=.,,

def FoldText(): string
    return $"{getline(v:foldstart)} … {v:foldend - v:foldstart + 1}"
enddef
set foldtext=FoldText()

if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

&directory = $'{fnamemodify($MYVIMRC, ":p:h")}/.data/swap/'
&backupdir = $'{fnamemodify($MYVIMRC, ":p:h")}/.data/backup//'
&undodir = $'{fnamemodify($MYVIMRC, ":p:h")}/.data/undo//'
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile
