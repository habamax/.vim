" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed:
" WIN:
" git clone https://github.com/k-takata/minpac.git %HOME%/vimfiles/pack/minpac/opt/minpac
" WIN POWERSHELL:
" git clone https://github.com/k-takata/minpac.git $HOME/vimfiles/pack/minpac/opt/minpac
" OTHER:
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

" Plugins {{{1
if exists('*minpac#init')
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	"" Tim Pope is a beast. You better use his stuff ...
	call minpac#add('tpope/vim-commentary')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-dispatch')
	call minpac#add('tpope/vim-speeddating')
	call minpac#add('tpope/vim-scriptease')
	call minpac#add('tpope/vim-unimpaired')
	call minpac#add('tpope/vim-eunuch')
	" coerce word with cru :h cr
	call minpac#add('tpope/vim-abolish')
	call minpac#add('tpope/vim-endwise')
	call minpac#add('tpope/vim-vinegar')
	call minpac#add('tpope/vim-obsession')

	"" Git
	call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
	call minpac#add('rbong/vim-flog', {'type': 'opt'})

	"" Fuzzy stuff
	call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
	call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})
	call minpac#add('junegunn/fzf', {'type': 'opt'})
	call minpac#add('junegunn/fzf.vim', {'type': 'opt'})

	"" Text manipulation
	call minpac#add('tommcdo/vim-exchange')
	call minpac#add('tmhedberg/matchit')
	" use gsip to sort linewise
	" use gsib to sort in a parenthesis
	call minpac#add('christoomey/vim-sort-motion')
	call minpac#add('junegunn/vim-easy-align')
	" swap comma separated stuff with `g>` `g<` `gs`
	" `gs` will probably interfere with vim-sort-motion
	" map it to `g.`
	call minpac#add('machakann/vim-swap')
	" parenthesis auto-pair
	call minpac#add('tmsvg/pear-tree')

	"" Completion/Expansion
	call minpac#add('SirVer/ultisnips', {'type': 'opt'})
	call minpac#add('honza/vim-snippets', {'type': 'opt'})
	call minpac#add('mattn/emmet-vim')
	call minpac#add('alvan/vim-closetag')

	"" Text objects
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('kana/vim-textobj-indent')
	call minpac#add('kana/vim-textobj-function')
	call minpac#add('thinca/vim-textobj-function-javascript')
	call minpac#add('andyl/vim-textobj-elixir')

	"" Programming
	" call minpac#add('natebosch/vim-lsc')
	call minpac#add('w0rp/ale')
	call minpac#add('elixir-editors/vim-elixir')
	call minpac#add('udalov/kotlin-vim')
	call minpac#add('editorconfig/editorconfig-vim')

	"" Misc
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')
	call minpac#add('diepm/vim-rest-console')
	call minpac#add('mbbill/undotree')
	call minpac#add('airblade/vim-rooter')
	call minpac#add('chrisbra/Colorizer')


	"" Colors
	call minpac#add('nanotech/jellybeans.vim')
	call minpac#add('morhetz/gruvbox')
	call minpac#add('dracula/vim', {'name': 'dracula'})
endif

" Commands to update and clean plugins {{{1
command! PackUpdate packadd minpac | runtime minpac_list.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime minpac_list.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime minpac_list.vim | call minpac#status()
