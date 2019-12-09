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
	call minpac#add('tpope/vim-endwise')
	" vinegar is small extension to Netrw
	call minpac#add('tpope/vim-vinegar')
	" Sessions
	call minpac#add('tpope/vim-obsession')
	" Databases
	call minpac#add('tpope/vim-dadbod')

	"" Git
	call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
	call minpac#add('rbong/vim-flog', {'type': 'opt'})

	"" Fuzzy stuff
	call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})
	" backup (no external dependencies, just newer vim)
	call minpac#add('liuchengxu/vim-clap', {'type': 'opt'})
	call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})


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
	" doesn't play well with neovim.
	call minpac#add('machakann/vim-swap')
	" parenthesis auto-pair, it clashes with tpope's endwise unfortunately.
	" call minpac#add('tmsvg/pear-tree')

	" preview of :s command
	call minpac#add('markonm/traces.vim')


	"" Text objects
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('kana/vim-textobj-indent')
	call minpac#add('kana/vim-textobj-function')
	call minpac#add('thinca/vim-textobj-function-javascript')
	call minpac#add('andyl/vim-textobj-elixir')

	"" Programming
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('editorconfig/editorconfig-vim')
	call minpac#add('elixir-editors/vim-elixir')
	call minpac#add('mhinz/vim-mix-format')
	call minpac#add('udalov/kotlin-vim')
	call minpac#add('aklt/plantuml-syntax')
	call minpac#add('dart-lang/dart-vim-plugin')

	"" Language Server Protocol and completion
	call minpac#add('prabirshrestha/vim-lsp')
	call minpac#add('prabirshrestha/async.vim')
	call minpac#add('prabirshrestha/asyncomplete.vim')
	call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
	" call minpac#add('natebosch/vim-lsc')
	" call minpac#add('natebosch/vim-lsc-dart')

	"" Completion/Expansion
	call minpac#add('ervandew/supertab')
	call minpac#add('SirVer/ultisnips', {'type': 'opt'})
	call minpac#add('honza/vim-snippets', {'type': 'opt'})
	" call minpac#add('mattn/emmet-vim')
	call minpac#add('alvan/vim-closetag')

	"" Misc
	" yog to trigger goyo
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')

	" call minpac#add('Konfekt/vim-CtrlXA')


	" awesome
	call minpac#add('mbbill/undotree')
	
	" VIAL adds ~900ms to nvim startup...
	" http requests...
	" call minpac#add('diepm/vim-rest-console')
	" use forked vial
	" call minpac#add('baverman/vial')
	" call minpac#add('baverman/vial-http')

	call minpac#add('airblade/vim-rooter')

	" RGB2Term is nice
	" call minpac#add('chrisbra/Colorizer')
	" call minpac#add('RRethy/vim-hexokinase')

	" really good implementation of kill-ring
	call minpac#add('svermeulen/vim-yoink')


	" Multiple cursors
	" Italiano Vero -- mg979 has contributed a lot to vim-asciidoctor
	" And coincidently he does a very good implementation of multiple cursors
	" a like plugin
	call minpac#add('mg979/vim-visual-multi')

	" Firenvim works in windows!
	" Don't forget to :call firenvim#install(0) after install
	call minpac#add('glacambre/firenvim')
	
	"" Colors
	call minpac#add('lifepillar/vim-solarized8')
	call minpac#add('lifepillar/vim-gruvbox8')
	call minpac#add('chriskempson/base16-vim')
endif

" Commands to update and clean plugins {{{1
command! PackUpdate packadd minpac | runtime plugins.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime plugins.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime plugins.vim | call minpac#status()
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
	call minpac#add('tpope/vim-endwise')
	" vinegar is small extension to Netrw
	" call minpac#add('tpope/vim-vinegar')
	" Sessions
	call minpac#add('tpope/vim-obsession')
	" Databases
	call minpac#add('tpope/vim-dadbod')

	"" Git
	call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
	call minpac#add('rbong/vim-flog', {'type': 'opt'})

	"" Fuzzy stuff
	call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})
	" backup (no external dependencies, just newer vim)
	call minpac#add('liuchengxu/vim-clap', {'type': 'opt'})
	call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})


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
	" doesn't play well with neovim.
	call minpac#add('machakann/vim-swap')
	" parenthesis auto-pair, it clashes with tpope's endwise unfortunately.
	" call minpac#add('tmsvg/pear-tree')

	" preview of :s command
	call minpac#add('markonm/traces.vim')


	"" Text objects
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('kana/vim-textobj-indent')
	call minpac#add('kana/vim-textobj-function')
	call minpac#add('thinca/vim-textobj-function-javascript')
	call minpac#add('andyl/vim-textobj-elixir')

	"" Programming
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('editorconfig/editorconfig-vim')
	call minpac#add('elixir-editors/vim-elixir')
	call minpac#add('mhinz/vim-mix-format')
	call minpac#add('udalov/kotlin-vim')
	call minpac#add('aklt/plantuml-syntax')
	call minpac#add('dart-lang/dart-vim-plugin')

	"" Language Server Protocol and completion
	call minpac#add('prabirshrestha/vim-lsp')
	call minpac#add('prabirshrestha/async.vim')
	call minpac#add('prabirshrestha/asyncomplete.vim')
	call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
	" call minpac#add('natebosch/vim-lsc')
	" call minpac#add('natebosch/vim-lsc-dart')

	"" Completion/Expansion
	call minpac#add('ervandew/supertab')
	call minpac#add('SirVer/ultisnips', {'type': 'opt'})
	call minpac#add('honza/vim-snippets', {'type': 'opt'})
	" call minpac#add('mattn/emmet-vim')
	call minpac#add('alvan/vim-closetag')

	"" Misc
	" yog to trigger goyo
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')

	" call minpac#add('Konfekt/vim-CtrlXA')

	call minpac#add('justinmk/vim-dirvish')


	" awesome
	call minpac#add('mbbill/undotree')
	
	" VIAL adds ~900ms to nvim startup...
	" http requests...
	" call minpac#add('diepm/vim-rest-console')
	" use forked vial
	" call minpac#add('baverman/vial')
	" call minpac#add('baverman/vial-http')

	call minpac#add('airblade/vim-rooter')

	" RGB2Term is nice
	" call minpac#add('chrisbra/Colorizer')
	" call minpac#add('RRethy/vim-hexokinase')

	" really good implementation of kill-ring
	call minpac#add('svermeulen/vim-yoink')


	" Multiple cursors
	" Italiano Vero -- mg979 has contributed a lot to vim-asciidoctor
	" And coincidently he does a very good implementation of multiple cursors
	" a like plugin
	call minpac#add('mg979/vim-visual-multi')

	" Firenvim works in windows!
	" Don't forget to :call firenvim#install(0) after install
	call minpac#add('glacambre/firenvim')
	
	"" Colors
	call minpac#add('lifepillar/vim-solarized8')
	call minpac#add('lifepillar/vim-gruvbox8')
	call minpac#add('chriskempson/base16-vim')
endif

" Commands to update and clean plugins {{{1
command! PackUpdate packadd minpac | runtime plugins.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime plugins.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime plugins.vim | call minpac#status()
" " Use vim-packager to utilize standard vim package stuff + git
" " First of all vim-packager should be installed:
" " WIN:
" " git clone https://github.com/kristijanhusak/vim-packager %HOME%/vimfiles/pack/packager/opt/vim-packager
" " WIN POWERSHELL:
" " git clone https://github.com/kristijanhusak/vim-packager $HOME/vimfiles/pack/packager/opt/vim-packager
" " OTHER:
" " git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager

" " Plugins {{{1
" if exists('*packager#init')
" 	call packager#init()
" 	call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

" 	"" Tim Pope is a beast. You better use his stuff ...
" 	call packager#add('tpope/vim-commentary')
" 	call packager#add('tpope/vim-surround')
" 	call packager#add('tpope/vim-repeat')
" 	call packager#add('tpope/vim-dispatch')
" 	call packager#add('tpope/vim-speeddating')
" 	call packager#add('tpope/vim-scriptease')
" 	call packager#add('tpope/vim-unimpaired')
" 	call packager#add('tpope/vim-eunuch')
" 	call packager#add('tpope/vim-endwise')
" 	" vinegar is small extension to Netrw
" 	call packager#add('tpope/vim-vinegar')
" 	" Sessions
" 	call packager#add('tpope/vim-obsession')
" 	" Databases
" 	call packager#add('tpope/vim-dadbod')

" 	"" Git
" 	call packager#add('tpope/vim-fugitive', {'type': 'opt'})
" 	call packager#add('rbong/vim-flog', {'type': 'opt'})

" 	"" Fuzzy stuff
" 	call packager#add('Yggdroot/LeaderF', {'type': 'opt'})
" 	" backup (no external dependencies, just newer vim)
" 	call packager#add('liuchengxu/vim-clap', {'type': 'opt'})
" 	call packager#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})


" 	"" Text manipulation
" 	call packager#add('tommcdo/vim-exchange')
" 	call packager#add('tmhedberg/matchit')
" 	" use gsip to sort linewise
" 	" use gsib to sort in a parenthesis
" 	call packager#add('christoomey/vim-sort-motion')
" 	call packager#add('junegunn/vim-easy-align')
" 	" swap comma separated stuff with `g>` `g<` `gs`
" 	" `gs` will probably interfere with vim-sort-motion
" 	" map it to `g.`
" 	" doesn't play well with neovim.
" 	call packager#add('machakann/vim-swap')
" 	" parenthesis auto-pair, it clashes with tpope's endwise unfortunately.
" 	" call packager#add('tmsvg/pear-tree')

" 	" preview of :s command
" 	call packager#add('markonm/traces.vim')


" 	"" Text objects
" 	call packager#add('kana/vim-textobj-user')
" 	call packager#add('kana/vim-textobj-indent')
" 	call packager#add('kana/vim-textobj-function')
" 	call packager#add('thinca/vim-textobj-function-javascript')
" 	call packager#add('andyl/vim-textobj-elixir')

" 	"" Programming
" 	call packager#add('ludovicchabant/vim-gutentags')
" 	call packager#add('editorconfig/editorconfig-vim')
" 	call packager#add('elixir-editors/vim-elixir')
" 	call packager#add('mhinz/vim-mix-format')
" 	call packager#add('udalov/kotlin-vim')
" 	call packager#add('aklt/plantuml-syntax')
" 	call packager#add('dart-lang/dart-vim-plugin')

" 	"" Language Server Protocol and completion
" 	call packager#add('prabirshrestha/vim-lsp')
" 	call packager#add('prabirshrestha/async.vim')
" 	call packager#add('prabirshrestha/asyncomplete.vim')
" 	call packager#add('prabirshrestha/asyncomplete-lsp.vim')
" 	" call packager#add('natebosch/vim-lsc')
" 	" call packager#add('natebosch/vim-lsc-dart')

" 	"" Completion/Expansion
" 	call packager#add('ervandew/supertab')
" 	call packager#add('SirVer/ultisnips', {'type': 'opt'})
" 	call packager#add('honza/vim-snippets', {'type': 'opt'})
" 	" call packager#add('mattn/emmet-vim')
" 	call packager#add('alvan/vim-closetag')

" 	"" Misc
" 	" yog to trigger goyo
" 	call packager#add('junegunn/goyo.vim')
" 	call packager#add('junegunn/limelight.vim')

" 	" call packager#add('Konfekt/vim-CtrlXA')


" 	" awesome
" 	call packager#add('mbbill/undotree')
	
" 	" VIAL adds ~900ms to nvim startup...
" 	" http requests...
" 	" call packager#add('diepm/vim-rest-console')
" 	" use forked vial
" 	" call packager#add('baverman/vial')
" 	" call packager#add('baverman/vial-http')

" 	call packager#add('airblade/vim-rooter')

" 	" RGB2Term is nice
" 	" call packager#add('chrisbra/Colorizer')
" 	" call packager#add('RRethy/vim-hexokinase')

" 	" really good implementation of kill-ring
" 	call packager#add('svermeulen/vim-yoink')


" 	" Multiple cursors
" 	" Italiano Vero -- mg979 has contributed a lot to vim-asciidoctor
" 	" And coincidently he does a very good implementation of multiple cursors
" 	" a like plugin
" 	call packager#add('mg979/vim-visual-multi')

" 	" Firenvim works in windows!
" 	" Don't forget to :call firenvim#install(0) after install
" 	call packager#add('glacambre/firenvim')
	
" 	"" Colors
" 	call packager#add('lifepillar/vim-solarized8')
" 	call packager#add('lifepillar/vim-gruvbox8')
" 	call packager#add('chriskempson/base16-vim')
" endif

" command! PackInstall exe "packadd vim-packager | runtime plugins.vim | call packager#install()"
" command! -bang PackUpdate exe "packadd vim-packager | runtime plugins.vim | call packager#update({ 'force_hooks': '<bang>' })"
" command! PackClean exe "packadd vim-packager | runtime plugins.vim | call packager#clean()"
" command! PackStatus exe "packadd vim-packager | runtime plugins.vim | call packager#status()"
