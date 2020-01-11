" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed:
" WIN:
" git clone https://github.com/k-takata/minpac.git %HOME%/vimfiles/pack/minpac/opt/minpac
" WIN POWERSHELL:
" git clone https://github.com/k-takata/minpac.git $HOME/vimfiles/pack/minpac/opt/minpac
" OTHER:
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

"" Plugins {{{1
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
	call minpac#add('tpope/vim-endwise')
	" Sessions
	call minpac#add('tpope/vim-obsession')
	" Databases
	call minpac#add('tpope/vim-dadbod')


	"" Git
	call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
	call minpac#add('rbong/vim-flog', {'type': 'opt'})


	"" Fuzzy stuff
	call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})
	" backup (no external dependencies)
	call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
	" call minpac#add('liuchengxu/vim-clap', {'type': 'opt'})


	"" Text manipulation
	" must have
	call minpac#add('mbbill/undotree')

	" cxiw .
	call minpac#add('tommcdo/vim-exchange')

	" use gsip to sort linewise
	" use gsib to sort in a parenthesis
	call minpac#add('christoomey/vim-sort-motion')

	call minpac#add('junegunn/vim-easy-align')

	" swap comma separated stuff with `g>` `g<` `gs`
	" `gs` will probably interfere with vim-sort-motion
	" map it to `g.`
	" doesn't play well with neovim.
	call minpac#add('machakann/vim-swap')

	" really good implementation of kill-ring
	call minpac#add('svermeulen/vim-yoink')

	" Multiple cursors
	" Italiano Vero -- mg979 has contributed a lot to vim-asciidoctor
	" And coincidently he does a very good implementation of multiple cursors
	" a like plugin
	call minpac#add('mg979/vim-visual-multi')


	"" Text objects
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('kana/vim-textobj-indent')
	call minpac#add('kana/vim-textobj-function')
	call minpac#add('thinca/vim-textobj-function-javascript')
	call minpac#add('andyl/vim-textobj-elixir')


	"" Programming
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('editorconfig/editorconfig-vim')
	call minpac#add('mhinz/vim-mix-format')
	call minpac#add('AndrewRadev/splitjoin.vim')


	"" Filetype & Syntax
	call minpac#add('elixir-editors/vim-elixir')
	call minpac#add('udalov/kotlin-vim')
	call minpac#add('aklt/plantuml-syntax')
	call minpac#add('dart-lang/dart-vim-plugin')


	"" Language Server Protocol and completion
	call minpac#add('prabirshrestha/vim-lsp')
	call minpac#add('mattn/vim-lsp-settings')
	call minpac#add('mattn/vim-lsp-icons')
	call minpac#add('prabirshrestha/async.vim')
	" use forked as of now
	" git clone https://github.com/habamax/asyncomplete.vim $HOME/vimfiles/pack/habamax/start/asyncomplete.vim
	" call minpac#add('prabirshrestha/asyncomplete.vim')
	call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
	" use forked as of now
	" git clone https://github.com/habamax/asyncomplete-buffer.vim $HOME/vimfiles/pack/habamax/start/asyncomplete-buffer.vim
	" call minpac#add('prabirshrestha/asyncomplete-buffer.vim')
	call minpac#add('prabirshrestha/asyncomplete-file.vim')


	"" Snippets
	call minpac#add('hrsh7th/vim-vsnip')
	call minpac#add('hrsh7th/vim-vsnip-integ')

	" Close tags with > and >> in insert mode
	call minpac#add('alvan/vim-closetag')


	"" Miscelaneous

	" rest console with curl
	call minpac#add('diepm/vim-rest-console')

	" better vim-matchit
	call minpac#add('andymass/vim-matchup')

	" preview of :s command
	call minpac#add('markonm/traces.vim')

	" yog to trigger goyo
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')

	" NETRW should be this
	call minpac#add('justinmk/vim-dirvish')

	" auto cd to your project root folder
	call minpac#add('airblade/vim-rooter')

	"" RGB2Term is nice
	" call minpac#add('chrisbra/Colorizer')
	" call minpac#add('RRethy/vim-hexokinase')

	" Embed neovim into firefox textboxes.
	" Firenvim works in windows!
	call minpac#add('glacambre/firenvim',
				\ { 'type': 'opt',
				\ 'do': 'if has("nvim") | packadd firenvim | call firenvim#install(0) | endif'
				\ })
	

	"" Colors
	call minpac#add('chriskempson/base16-vim')
endif

"" Commands to update and clean plugins {{{1
command! PackUpdate packadd minpac | runtime plugins.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime plugins.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime plugins.vim | call minpac#status()
