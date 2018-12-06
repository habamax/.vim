" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed:
" WIN:
" git clone https://github.com/k-takata/minpac.git %HOME/vimfiles/pack/minpac/opt/minpac
" OTHER:
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

" Plugins {{{1
fun! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('editorconfig/editorconfig-vim')

	" Tim Pope is a beast. You better use his stuff ...
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-commentary')
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-dispatch')
	call minpac#add('tpope/vim-speeddating')
	call minpac#add('tpope/vim-scriptease')
	call minpac#add('tpope/vim-unimpaired')
	call minpac#add('tpope/vim-eunuch')
	call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
	" call minpac#add('tpope/vim-sexp-mappings-for-regular-people')
	" call minpac#add('tpope/vim-fireplace')
	call minpac#add('tpope/vim-endwise')

	call minpac#add('tmhedberg/matchit')


	" <leader>hs to stage hunk
	" <leader>hu to undo hunk
	" ]c next hunk
	" [c prev hunk
	call minpac#add('airblade/vim-gitgutter', {'type': 'opt'})

	call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
	call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})

	" Python should be installed. PATH should be set up to python37.dll
	call minpac#add('maralla/completor.vim', {'type': 'opt'})

	call minpac#add('Raimondi/delimitMate')

	" use gsip to sort linewise
	" use gsib to sort in a parenthesis
	call minpac#add('christoomey/vim-sort-motion')

	" swap comma separated stuff with `g>` `g<` `gs`
	" `gs` will probably interfere with vim-sort-motion
	" map it to `g.`
	call minpac#add('machakann/vim-swap')


	call minpac#add('christoomey/vim-titlecase')

	call minpac#add('mhinz/vim-grepper')

	call minpac#add('junegunn/vim-easy-align')

	" text objects
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('kana/vim-textobj-indent')
	call minpac#add('kana/vim-textobj-function')
	call minpac#add('thinca/vim-textobj-function-javascript')
	call minpac#add('andyl/vim-textobj-elixir')

	" no clojure and racket for now
	" call minpac#add('guns/vim-sexp')

	call minpac#add('w0rp/ale')
	call minpac#add('benekastah/neomake')
	call minpac#add('ludovicchabant/vim-gutentags', {'type': 'opt'})

	call minpac#add('SirVer/ultisnips', {'type': 'opt'})
	call minpac#add('honza/vim-snippets', {'type': 'opt'})
	call minpac#add('mattn/emmet-vim')
	call minpac#add('alvan/vim-closetag')

	call minpac#add('scrooloose/nerdtree')
	
	" I have a fork to fix an issue...
	" call minpac#add('diepm/vim-rest-console')

	" languages
	call minpac#add('elixir-editors/vim-elixir')
	call minpac#add('mhinz/vim-mix-format')
	call minpac#add('udalov/kotlin-vim')
	
	" Distraction free
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')

	" colors
	call minpac#add('dracula/vim', {'name': 'dracula'})
	call minpac#add('nanotech/jellybeans.vim')
	call minpac#add('chriskempson/base16-vim')
endf

" Commands to update and clean plugins {{{1
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

