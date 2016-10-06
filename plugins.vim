" Plugins {{{1
" Vim-Plug bootstrapping. {{{2
" Don't forget to call :PlugInstall
" TODO: this should be tweaked for win/linux/osx boxes!
let s:vimrc_path = fnamemodify($MYVIMRC, ":p:h")."/"

let s:vim_plug_installed = filereadable(s:vimrc_path.'autoload/plug.vim')

" Do not load plugins if plugin manager is not installed.
if !s:vim_plug_installed
	finish
endif

" Here be plugins {{{2
" tune it to store plugins in correct directory
call plug#begin(s:vimrc_path.'plugged')
let g:plug_timeout = 180


Plug 'benekastah/neomake'
" {{{ TODO: only when neomake is installed!!!
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

Plug 'junegunn/rainbow_parentheses.vim'
nnoremap <leader>xp :RainbowParentheses!!<CR>

Plug 'tmhedberg/matchit'

" Tim Pope is a beast. You better use his stuff ...
Plug 'tpope/vim-surround'
let g:surround_113 = "«\r»"

" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-scriptease'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-rsi'
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1

Plug 'vim-pandoc/vim-pandoc'
let g:pandoc#modules#disabled = ["command", "templates", "menu", "bibliographies"]
let g:pandoc#folding#mode = 'stacked'
let g:pandoc#folding#fold_yaml = 1
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#syntax#conceal#use = 0

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = ''
nnoremap <leader>ff :CtrlPMixed<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
let g:ctrlp_key_loop = 1

" Plug 'SirVer/ultisnips'
" Snippets are separated from the engine.
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsSnippetsDir=s:vimrc_path."/UltiSnips/"
Plug 'honza/vim-snippets'


Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = s:vimrc_path."snips"
" if has('conceal')
	" set conceallevel=2 concealcursor=niv
" endif

Plug 'mhinz/vim-grepper'

let g:skipit_default_mappings = 0
Plug 'habamax/vim-skipit'
" Plug '~/vimfiles/vimdev/vim-skipit'
imap <C-l> <Plug>SkipItForward

Plug 'chriskempson/base16-vim'

call plug#end()
