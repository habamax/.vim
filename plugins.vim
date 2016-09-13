" Plugins {{{1
" Vim-Plug bootstrapping. {{{2
" Don't forget to call :PlugInstall
let g:vim_plug_installed = filereadable(expand('~/.vim/autoload/plug.vim'))
if !g:vim_plug_installed
	echomsg "Install vim-plug with 'InstallVimPlug' command and restart vim."
	echomsg "'curl' should be installed first"
	command InstallVimPlug !mkdir -p ~/.vim/autoload |
			\ curl -fLo ~/.vim/autoload/plug.vim
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Do not load plugins if plugin manager is not installed.
if !g:vim_plug_installed
	finish
endif

" Here be plugins {{{2
call plug#begin('~/.vim/plugged')
let g:plug_timeout = 180

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
" Set up FZF {{{3
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

fun! s:fzf_root()
	let path = finddir(".git", expand("%:p:h").";")
	return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>ll :Lines<CR>
nnoremap <silent> <Leader>lb :BLines<CR>

"}}}

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --omnisharp-completer' }
"Plug 'Shougo/neocomplete.vim' "{{{
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_auto_select = 0
"let g:neocomplete#enable_auto_delimiter = 1
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"	return neocomplete#close_popup() . "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>p umvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y> neocomplete#close_popup()
"inoremap <expr><C-e> neocomplete#cancel_popup()
""}}}

Plug 'vimwiki/vimwiki', {'branch': 'dev'}

Plug 'benekastah/neomake'
" {{{
  autocmd! BufWritePost * Neomake
  " let g:neomake_airline = 0
  let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
  let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }

  " map <F4> :lopen<CR>
  map <leader>rm :Neomake<CR>
" }}}

Plug 'Raimondi/delimitMate'
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2

Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_comment = 0 " align comments
vnoremap <silent> <Enter> :EasyAlign<cr>
nmap ga <Plug>(EasyAlign)

Plug 'junegunn/rainbow_parentheses.vim'
nnoremap <leader>xp :RainbowParentheses!!<CR>

Plug 'tmhedberg/matchit'

" Tim Pope is a beast. You better use his stuff ...
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>

Plug 'habamax/vim-skipit'

" Colorschemes"{{{
Plug 'jnurmine/Zenburn'
Plug 'nanotech/jellybeans.vim'
"}}}

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1


call plug#end()

