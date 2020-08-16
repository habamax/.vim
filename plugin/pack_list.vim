" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed:
" WIN:
" git clone https://github.com/k-takata/minpac.git %HOME%/vimfiles/pack/minpac/opt/minpac
" WIN POWERSHELL:
" git clone https://github.com/k-takata/minpac.git $HOME/vimfiles/pack/minpac/opt/minpac
" OTHER:
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

command! PackUpdate packadd minpac | runtime plugin/pack_list.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime plugin/pack_list.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime plugin/pack_list.vim | call minpac#status()


if !exists('*minpac#init') | finish | endif


call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

"" My plugins
" call minpac#add('habamax/vim-list-man')
" call minpac#add('habamax/vim-change-font-size')
call minpac#add('git@github.com:habamax/vim-asciidoctor.git', {'rev': 'master'})
" call minpac#add('git@github.com:habamax/vim-asciidoctor.git', {'rev': 'multiline_bolditalic'})
call minpac#add('git@github.com:habamax/vim-evalvim.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-habanight.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-polar.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-colors-defminus.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-colors-defnoche.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-colors-lessthan.git', {'type': 'opt', 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-do-outline.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-elixir-mix-test.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-godot.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-num2words.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-sendtoterm.git', {'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-winlayout.git', {'rev': 'master'})


"" Tim Pope is a beast. You better use his stuff ...
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-scriptease')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-endwise')


"" Git
call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
call minpac#add('rbong/vim-flog', {'type': 'opt'})

"" GitHub Gists
call minpac#add('mattn/webapi-vim', {'type': 'opt'})
call minpac#add('mattn/vim-gist', {'type': 'opt'})


"" Fuzzy stuff
" FZF is quite good, but not really polished for windows users
call minpac#add('junegunn/fzf', {'type': 'opt'})
call minpac#add('junegunn/fzf.vim', {'type': 'opt'})
" backup (no external dependencies)
call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})

"" Text manipulation
" must have
call minpac#add('mbbill/undotree')

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
call minpac#add('mg979/vim-visual-multi')


"" Programming
call minpac#add('ludovicchabant/vim-gutentags', {'type': 'opt'})
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('mhinz/vim-mix-format')
call minpac#add('AndrewRadev/splitjoin.vim')


"" Filetype & Syntax
call minpac#add('elixir-editors/vim-elixir')
call minpac#add('aklt/plantuml-syntax')
" call minpac#add('dart-lang/dart-vim-plugin')


"" Language Server Protocol and completion
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

" backup general <tab> completion
call minpac#add('lifepillar/vim-mucomplete')

" Close tags with > and >> in insert mode
call minpac#add('alvan/vim-closetag')


"" Miscelaneous
" enhance [I ]I [D ]D
" call minpac#add('romainl/vim-qlist')

" rest console with curl
call minpac#add('diepm/vim-rest-console')

" gof (filemanager) and got (terminal)
call minpac#add('justinmk/vim-gtfo')

" preview of :s command
call minpac#add('markonm/traces.vim')

" NETRW should be this
call minpac#add('justinmk/vim-dirvish')

" auto cd to your project root folder
call minpac#add('airblade/vim-rooter')

call minpac#add('dstein64/vim-startuptime')

call minpac#add('lifepillar/vim-colortemplate')
