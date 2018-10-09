" Plugins
" Vim-Plug bootstrapping. {{{1
" Don't forget to call :PlugInstall
" TODO: this should be tweaked for win/linux/osx boxes!
let s:vimrc_path = fnamemodify($MYVIMRC, ":p:h")."/"

let s:vim_plug_installed = filereadable(s:vimrc_path.'autoload/plug.vim')

" Do not load plugins if plugin manager is not installed.
if !s:vim_plug_installed
	finish
endif

" Here be the plugins {{{1
" Tune it to store plugins in correct directory
call plug#begin(s:vimrc_path.'plugged')
let g:plug_timeout = 180

Plug 'tmhedberg/matchit'

Plug 'benekastah/neomake'

" Python should be installed. PATH should be set up to python37.dll
Plug 'maralla/completor.vim'

" WhichKey {{{1
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Text objects {{{1
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'


" Tim Pope is a beast. You better use his stuff ... {{{1
Plug 'tpope/vim-surround'

" XML and HTML stuff
Plug 'tpope/vim-ragtag'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'


Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'jiangmiao/auto-pairs'

" use gsip to sort linewise
" use gsib to sort in a parenthesis
Plug 'christoomey/vim-sort-motion'

Plug 'christoomey/vim-titlecase'

" Plug 'junegunn/rainbow_parentheses.vim'
" nnoremap <leader>xp :RainbowParentheses!!<CR>

Plug 'mhinz/vim-grepper'

Plug 'junegunn/vim-easy-align'

Plug 'chrisbra/csv.vim'

Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'cocopon/iceberg.vim'
Plug 'owickstrom/vim-colors-paramount'


call plug#end()
