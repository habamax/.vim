" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed (windows):
" cd /d %USERPROFILE%
" git clone https://github.com/k-takata/minpac.git vimfiles\pack\minpac\opt\minpac

" Commands to update and clean plugins {{{1
command! PackUpdate packadd minpac | runtime minpac_list.vim | call minpac#update() | call minpac#status()
command! PackClean  packadd minpac | runtime minpac_list.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime minpac_list.vim | call minpac#status()

" External dependencies {{{1
if executable("git")
	packadd vim-fugitive
	packadd vim-gitgutter
endif

" Plugins {{{1
if exists('*minpac#init')
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('tpope/vim-surround')
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
	call minpac#add('tpope/vim-sexp-mappings-for-regular-people')
	call minpac#add('tpope/vim-fireplace')
	call minpac#add('tpope/vim-endwise')
	call minpac#add('tpope/vim-dadbod')

	call minpac#add('tmhedberg/matchit')

	call minpac#add('benekastah/neomake')
	call minpac#add('alvan/vim-closetag')

	" <leader>hs to stage hunk
	" <leader>hu to undo hunk
	" ]c next hunk
	" [c prev hunk
	call minpac#add('airblade/vim-gitgutter', {'type': 'opt'})

	call minpac#add('vim-airline/vim-airline')
	call minpac#add('vim-airline/vim-airline-themes')
	" call minpac#add('itchyny/lightline.vim')


	call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
	call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})

	call minpac#add('jreybert/vimagit')

	" call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})

	" Python should be installed. PATH should be set up to python37.dll
	call minpac#add('maralla/completor.vim')

	" well, this plugin will quite good
	" breaks some russian letters. Like жЖхХъЪ
	" call minpac#add('jiangmiao/auto-pairs')

	call minpac#add('Raimondi/delimitMate')

	" use gsip to sort linewise
	" use gsib to sort in a parenthesis
	call minpac#add('christoomey/vim-sort-motion')

	call minpac#add('christoomey/vim-titlecase')

	" Plug 'junegunn/rainbow_parentheses.vim'
	" nnoremap <leader>xp :RainbowParentheses!!<CR>

	call minpac#add('mhinz/vim-grepper')

	call minpac#add('junegunn/vim-easy-align')

	call minpac#add('kana/vim-textobj-user')
	" call minpac#add('kana/vim-textobj-entire')
	call minpac#add('kana/vim-textobj-indent')

	call minpac#add('guns/vim-sexp')

	call minpac#add('w0rp/ale')

	call minpac#add('SirVer/ultisnips', {'type': 'opt'})
	call minpac#add('honza/vim-snippets', {'type': 'opt'})
	" call minpac#add('ipod825/vim-netranger')

	" colors
	call minpac#add('dracula/vim', {'name': 'dracula'})
	call minpac#add('morhetz/gruvbox')
	call minpac#add('tyrannicaltoucan/vim-deep-space')
	call minpac#add('cocopon/iceberg.vim')
	call minpac#add('owickstrom/vim-colors-paramount')
	call minpac#add('nanotech/jellybeans.vim')
	call minpac#add('rakr/vim-one')
	call minpac#add('cormacrelf/vim-colors-github')

endif

