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

" Here be the plugins {{{2
" Tune it to store plugins in correct directory
call plug#begin(s:vimrc_path.'plugged')
let g:plug_timeout = 180

Plug 'tmhedberg/matchit'

Plug 'benekastah/neomake'
if exists(":Neomake") == 2
	autocmd! BufWritePost * Neomake
	let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
	let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }
endif

" Python should be installed. PATH should be set up to python37.dll
Plug 'maralla/completor.vim'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>

Plug 'jiangmiao/auto-pairs'

" Plug 'junegunn/rainbow_parentheses.vim'
" nnoremap <leader>xp :RainbowParentheses!!<CR>

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'

" use gsip to sort linewise
" use gsib to sort in a parenthesis
Plug 'christoomey/vim-sort-motion'

" use <leader>ttip to titlecase a paragraph
Plug 'christoomey/vim-titlecase'
let g:titlecase_map_keys = 0
nmap <leader>tt <Plug>Titlecase
vmap <leader>tt <Plug>Titlecase
nmap <leader>tT <Plug>TitlecaseLine

" Tim Pope is a beast. You better use his stuff ...
Plug 'tpope/vim-surround'
" surround with q
let g:surround_113 = "«\r»"

" XML and HTML stuff
Plug 'tpope/vim-ragtag'
let g:ragtag_global_maps = 1

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gl :Glog<CR>


Plug 'airblade/vim-gitgutter'
" async doesn't work for my windows box
if has("win32")
	let g:gitgutter_async = 0
endif


Plug 'vim-airline/vim-airline'
let g:airline#extensions#keymap#enabled = '0'
Plug 'vim-airline/vim-airline-themes'

" Plug 'vim-pandoc/vim-pandoc'
" let g:pandoc#modules#disabled = ["command", "templates", "menu", "bibliographies"]
" let g:pandoc#folding#mode = 'stacked'
" let g:pandoc#folding#fold_yaml = 1
" Plug 'vim-pandoc/vim-pandoc-syntax'
" let g:pandoc#syntax#conceal#use = 0

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = ''
nnoremap <leader>ff :CtrlPMixed<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
let g:ctrlp_key_loop = 1
if executable('rg')
	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
	let g:ctrlp_use_caching = 0
elseif has("win32") || has("win64")
	let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
endif

Plug 'mhinz/vim-grepper'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Plug 'scrooloose/nerdtree'
" nnoremap <Leader>fn :NERDTreeToggle<CR>

" There will be asciidoctor plugin here
let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_themes_path = '~/docs/AsciiDocThemes'
let g:asciidoctor_pdf_fonts_path = '~/docs/AsciiDocThemes/fonts'

Plug 'chrisbra/csv.vim'

Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', { 'as': 'dracula' }


call plug#end()
