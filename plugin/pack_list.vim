" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed:
" WIN:
" git clone https://github.com/k-takata/minpac.git %HOME%/vimfiles/pack/minpac/opt/minpac
" WIN POWERSHELL:
" git clone https://github.com/k-takata/minpac.git $HOME/vimfiles/pack/minpac/opt/minpac
" OTHER:
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

command! PackUpdate packadd minpac | runtime plugin/pack_list.vim | call minpac#update()
command! PackClean  packadd minpac | runtime plugin/pack_list.vim | call minpac#clean()

if !exists('g:loaded_minpac') | finish | endif

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

"" My plugins
call minpac#add('git@github.com:habamax/vim-asciidoctor.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-evalvim.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-habanight.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-gruvbit.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-polar.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-do-outline.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-elixir-mix-test.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-godot.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-num2words.git', {'rev': 'master'})
" call minpac#add('git@github.com:habamax/vim-sendtoterm.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-winlayout.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-select.git', {'rev': 'master'})


"" Git
call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
call minpac#add('rbong/vim-flog', {'type': 'opt'})


"" Text manipulation
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')

" cxiw .
call minpac#add('tommcdo/vim-exchange')

call minpac#add('junegunn/vim-easy-align')

" swap comma separated stuff with `g>` `g<` `gs`
" `gs` will probably interfere with vim-sort-motion
" map it to `g.`
call minpac#add('machakann/vim-swap')

" Multiple cursors
" Italiano Vero -- mg979 has contributed a lot to vim-asciidoctor
" And coincidently he does a very good implementation of multiple cursors
" a like plugin
" call minpac#add('mg979/vim-visual-multi')


"" Programming
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-scriptease')
call minpac#add('ludovicchabant/vim-gutentags', {'type': 'opt'})
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('AndrewRadev/splitjoin.vim')


"" Filetype & Syntax
call minpac#add('elixir-editors/vim-elixir')
call minpac#add('aklt/plantuml-syntax')


"" Language Server Protocol and completion
call minpac#add('neoclide/coc.nvim', {'type': 'opt', 'branch': 'release'})
" after install/update run `./install.py`
" or `./install.py --go-completer` if you need go completion
call minpac#add('ycm-core/YouCompleteMe', {'type': 'opt'})

" backup general <tab> completion
call minpac#add('lifepillar/vim-mucomplete')

" Close tags with > and >> in insert mode
call minpac#add('alvan/vim-closetag')


"" Miscelaneous

call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-eunuch')


" rest console with curl
call minpac#add('diepm/vim-rest-console')

" preview of :s command
call minpac#add('markonm/traces.vim')

" File management
" call minpac#add('justinmk/vim-dirvish')
call minpac#add('lambdalisue/fern.vim')

" auto cd to your project root folder
call minpac#add('airblade/vim-rooter')

call minpac#add('lifepillar/vim-colortemplate')
call minpac#add('chrisbra/Colorizer')

" call minpac#add('vim-airline/vim-airline')
" call minpac#add('itchyny/lightline.vim')
