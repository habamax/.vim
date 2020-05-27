" Author: Maxim Kim <habamax@gmail.com>

"" Must have {{{1

" Make vim speak English
language messages en_US.UTF-8

filetype plugin indent on

syntax enable

set hidden

set encoding=utf8
set fileencoding=utf8
set fileformat=unix
set fileformats=unix,mac,dos


"" UI {{{1
set shortmess+=Ic
set winaltkeys=no
set guioptions=cM
set showtabline=1
set cmdheight=1
set nonumber norelativenumber
set lazyredraw
set splitbelow
set splitright
set helpheight=0
if !has('nvim') && has('patch-8.1.360')
    set diffopt=internal,filler,vertical,algorithm:patience
else
    set diffopt=filler,vertical
endif

if has('nvim')
    set inccommand=nosplit
endif

set scrolloff=2 sidescrolloff=0
set display+=lastline
set tabpagemax=50
set showmode

set confirm

set conceallevel=0

"" Unicode chars
set list
set listchars=tab:›\ ,extends:→,precedes:←,nbsp:·,trail:·
let &showbreak='╰ '

" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" turn off beeping... Old-fashioned way
" set visualbell
" au! GuiEnter * set t_vb=
" set t_vb=
set belloff=all

set completeopt=menuone
if !has('nvim') && v:version > 802 | set completeopt+=popup | endif

"" Text {{{1
set tabstop=8 softtabstop=-1 shiftwidth=4 expandtab smarttab
set shiftround
set autoindent

set nohlsearch incsearch
set ignorecase smartcase

set nowrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
set virtualedit=block
set formatoptions=cqjl

set spelllang=ru,en
set nospell

set commentstring=


"" Misc {{{1

" neovim loads clipboard.vim at startup having this option set
" and it makes startup slower.
" vim doesn't have this problem
" if !has("nvim")
"     set clipboard=unnamed
" endif

set sessionoptions=buffers,curdir,tabpages,winsize

" ripgrep as grepprg
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if has('mouse')
    set mouse=a
endif

" vim and terminals have hard time processing ESCs (laaaag)
" this helps a lot
set ttimeout
set ttimeoutlen=10


" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" better encryption
if has('crypt-blowfish2')
    set cryptmethod=blowfish2
endif

" remove default 'octal'.
" good for C-a, C-x wrt 007 and other octal like numbers
set nrformats=bin,hex


"" Mappings {{{1

let mapleader = "\<Space>"


" Fix Alt mappings for terminal vim
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
if !has('nvim') && !has('gui_running') && !has('win32')
    let c='a'
    while c <= 'z'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
    let c='0'
    while c <= '9'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
endif

" guards
nnoremap <leader>m <nop>
nnoremap <leader>o <nop>
nnoremap <Leader>d <nop>
nnoremap d<Leader> <nop>

nnoremap <BS> <C-^>
" killall buffers except current one
nnoremap <M-BS> :%bd<CR><C-^>:bd#<CR>

" UPPERCASE WORD
nnoremap <silent> <M-u> gUiww
" lowercase WORD
nnoremap <silent> <M-U> guiww

" UPPERCASE word in insert mode
inoremap <silent> <M-u> <ESC>gUiw`]a
" lowercase word in insert mode
inoremap <silent> <M-U> <ESC>guiw`]a


" Move line up/down
nnoremap <silent> <M-p> :<C-u>silent! exe "move-2"<CR>==
nnoremap <silent> <M-n> :<C-u>silent! exe "move+1"<CR>==
inoremap <silent> <M-p> <ESC>:<C-u>silent! exe "move-2"<CR>==gi
inoremap <silent> <M-n> <ESC>:<C-u>silent! exe "move+1"<CR>==gi
" Move selected lines up/down
xnoremap <silent> <M-p> :<C-u>silent! exe "'<,'>move-2"<CR>gv=gv
xnoremap <silent> <M-n> :<C-u>silent! exe "'<,'>move'>+"<CR>gv=gv

nnoremap <M-v> <C-v>
xnoremap <M-v> <C-v>

nnoremap <M-f> <C-d>
xnoremap <M-f> <C-d>
nnoremap <M-b> <C-u>
xnoremap <M-b> <C-u>

"" Window mangament
" switch to windows
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <leader>q <C-w>c
nnoremap <leader>ws <C-w>s
nnoremap <leader>wv <C-w>v
nnoremap <leader>wn <C-w>n
nnoremap <leader>wo <C-w>o
" maximize window
nnoremap <leader>wm <C-w>_<C-w>\|

" goto window
for wnr in range(1, 9)
    exe printf("nnoremap <space>%s %s<C-w>w", wnr, wnr)
    exe printf("nnoremap %s<space> %s<C-w>w", wnr, wnr)
endfor


nnoremap <silent> <F2> :echo win#layout_toggle()<CR>
nnoremap <silent> <leader>w1 :echo win#layout_horizontal()<CR>
nnoremap <silent> <leader>w2 :echo win#layout_vertical()<CR>
nnoremap <silent> <leader>w3 :echo win#layout_main_horizontal()<CR>
nnoremap <silent> <leader>w4 :echo win#layout_main_vertical()<CR>
nnoremap <silent> <leader>w5 :echo win#layout_tile()<CR>

nnoremap <silent> <F11> :echo win#layout_save()<CR>
nnoremap <silent> <F12> :echo win#layout_restore()<CR>


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <M-s> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u


" just one space on the line, preserving indent
nnoremap <leader><leader><leader> :FixText<CR>
xnoremap <leader><leader><leader> :FixText<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" shift right and left
xnoremap > >gv
xnoremap < <gv

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

nnoremap <leader>- :call text#underline(['-', '=', '~', '^', '+'])<CR>
nnoremap <leader>= :call text#underline(['=', '-', '~', '^', '+'])<CR>
nnoremap <leader>~ :call text#underline(['~', '=', '-', '^', '+'])<CR>
nnoremap <leader>^ :call text#underline(['^', '=', '-', '~', '+'])<CR>
nnoremap <leader>+ :call text#underline(['+', '=', '-', '~', '^'])<CR>

nnoremap <leader><leader>- o<home><ESC>78i-<ESC>
nnoremap <leader><leader>= o<home><ESC>78i=<ESC>

" find visually selected text
vnoremap * y/<C-R>"<CR>

nnoremap <leader>z zA

" edit init file (vimrc) -- nvim's init.vim sources vimrc
nnoremap <silent> <Leader>ei :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/init.vim"<CR>


" Directory ~/docs
nnoremap <silent> <Leader>dd :Docs<CR>
" Directory ~/vimfiles or ~/.vim
nnoremap <silent> <Leader>dv :VimConfigs<CR>



"" g:HOME is in paths.vim
" edit global todo file
nnoremap <silent> <Leader>et :exe printf('e %s/docs/todo.adoc', g:HOME)<CR>
" edit global journal file
nnoremap <silent> <Leader>ej :exe printf('e %s/docs/journal/2020.adoc', g:HOME)<CR>

" scroll other window
nnoremap <silent> <M-F> :call win#scroll_other(1)<CR>
nnoremap <silent> <M-B> :call win#scroll_other(0)<CR>

nnoremap <silent> gof :call os#file_manager()<CR>
nnoremap gx :call os#open_url(expand('<cWORD>'))<CR>

" Sort operator
func! Sort(type, ...)
    '[,']sort
endfunc
nmap <silent> gs :set opfunc=Sort<CR>g@
vmap <silent> gs :sort<CR>


"" Commands (and Autocommands) {{{1

cabbr ц w
cabbr й q
cabbr цй wq
cabbr ив bd

" Open (n)vim configs
command! Init :silent only
            \<bar>:exe printf("e %s/init.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/pack_list.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/pack_setup.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:exe printf("vs %s/after/plugin/init.vim", fnamemodify($MYVIMRC, ":p:h"))
            \<bar>:1wincmd w

" Open docs folder
command! Docs :exe printf('e %s/docs', g:HOME)

" Open vim config folder
command! VimConfigs :exe printf('e %s', fnamemodify($MYVIMRC, ":p:h"))

" remove trailing spaces
command! RemoveTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
            \:exe 'normal! ``'<bar>
            \:echo 'Remove trailing spaces and ^Ms.'


command! -range FixText <line1>,<line2>call text#fix()

" Continuous buffers.
" 1. Vertically split window
" 2. Offset it one screen
" 3. Scrollbind
command! ContinueInSplit
            \   exe "normal zR"
            \ | set noscrollbind
            \ | vsplit
            \ | exe "normal \<c-f>"
            \ | set scrollbind
            \ | wincmd p
            \ | set scrollbind

command! -range=% PasteVP call misc#vpaste(<line1>, <line2>)
command! -range=% PasteIX call misc#ix(<line1>, <line2>)
command! -range=% PasteCL call misc#clbin(<line1>, <line2>)

command! CD lcd %:p:h

" Not for Windows
" Write to a privileged file
if has("unix") || has("osxdarwin")
    command! W w !sudo tee "%" > /dev/null
endif

" highlight all occurrences of a term being searched/replaced
augroup hlsearch | au!
    au CmdlineEnter /,\? :set hlsearch
    au CmdlineLeave /,\? :set nohlsearch
augroup end

augroup restore_pos | au!
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup end


augroup win_autosize | au!
    au WinEnter * silent! call win#lens()
augroup end


if exists('##TextYankPost') && has('nvim')
    augroup hi_yanktext | au!
        au TextYankPost * silent! lua require'vim.highlight'.on_yank('Search', 200)
    augroup end
endif


"" Load Other Settings (plugins, colorscheme, etc) {{{1

" local machine settings, shouldn't be in the git repo
silent! source <sfile>:h/local.vim

source <sfile>:h/foldtext.vim

source <sfile>:h/paths.vim

source <sfile>:h/russian.vim

source <sfile>:h/statusline.vim

source <sfile>:h/tabline.vim

source <sfile>:h/abbreviations.vim

source <sfile>:h/color_setup.vim

if v:version >= 801 || has('nvim')
    source <sfile>:h/pack_setup.vim
    source <sfile>:h/pack_list.vim
endif
