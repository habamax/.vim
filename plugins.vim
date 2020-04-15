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

    "" Add my plugins
    " call minpac#add('habamax/vim-list-man')
    " call minpac#add('habamax/vim-change-font-size')
    call minpac#add('git@github.com:habamax/vim-asciidoctor.git', {'rev': 'master'})
    " call minpac#add('mg979/vim-asciidoctor', {'rev': 'multiline_bolditalic'})
    call minpac#add('git@github.com:habamax/vim-evalvim.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-colors-defminus.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-colors-defnoche.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-colors-lessthan.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-do-outline.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-elixir-mix-test.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-ft-gdscript.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-num2words.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-sendtoterm.git', {'rev': 'master'})
    call minpac#add('git@github.com:habamax/vim-winlayout.git', {'rev': 'master'})


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
    " call minpac#add('kristijanhusak/vim-dadbod-ui')


    "" Git
    call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
    call minpac#add('rbong/vim-flog', {'type': 'opt'})


    "" Fuzzy stuff
    " install optional dependency: ./install.bat or ./install.sh
    " from package root
    call minpac#add('Yggdroot/LeaderF', {'type': 'opt'})
    " FZF is quite good, but not really polished for windows users
    call minpac#add('junegunn/fzf', {'type': 'opt'})
    call minpac#add('junegunn/fzf.vim', {'type': 'opt'})
    " backup (no external dependencies)
    call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
    " clap is... buggy but has potential
    " call minpac#add('liuchengxu/vim-clap', {'type': 'opt'})


    "" Text manipulation
    " must have
    call minpac#add('mbbill/undotree')

    " cxiw .
    call minpac#add('tommcdo/vim-exchange')

    call minpac#add('wellle/targets.vim')

    " use gsip to sort linewise
    " call minpac#add('christoomey/vim-sort-motion')

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


    "" Programming
    call minpac#add('ludovicchabant/vim-gutentags', {'type': 'opt'})
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('mhinz/vim-mix-format')
    call minpac#add('AndrewRadev/splitjoin.vim')


    "" Filetype & Syntax
    call minpac#add('elixir-editors/vim-elixir')
    call minpac#add('wlangstroth/vim-racket')
    call minpac#add('udalov/kotlin-vim')
    call minpac#add('aklt/plantuml-syntax')
    call minpac#add('dart-lang/dart-vim-plugin')
  

    "" Language Server Protocol and completion
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('mattn/vim-lsp-settings')
    call minpac#add('mattn/vim-lsp-icons')
    call minpac#add('prabirshrestha/async.vim')
    call minpac#add('prabirshrestha/asyncomplete.vim')
    call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
    call minpac#add('ervandew/supertab')


    "" general completion works better then asyncomplete
    "" everything else is worse than vim-lsp
    " call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

    "" Snippets
    call minpac#add('hrsh7th/vim-vsnip')
    call minpac#add('hrsh7th/vim-vsnip-integ')

    " Close tags with > and >> in insert mode
    call minpac#add('alvan/vim-closetag')


    "" Miscelaneous
    " rest console with curl
    call minpac#add('diepm/vim-rest-console')

    " gof (filemanager) and got (terminal)
    call minpac#add('justinmk/vim-gtfo')

    " better vim-matchit
    call minpac#add('andymass/vim-matchup')

    " preview of :s command
    call minpac#add('markonm/traces.vim')

    " fast fold
    call minpac#add('Konfekt/FastFold')

    " NETRW should be this
    call minpac#add('justinmk/vim-dirvish')

    call minpac#add('vifm/vifm.vim')


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


    " Autosize windows
    " call minpac#add('camspiers/lens.vim')
    call minpac#add('habamax/lens.vim', {'branch': 'fix-resize'})

    call minpac#add('morhetz/gruvbox')
endif

"" Commands to update and clean plugins {{{1
command! PackUpdate packadd minpac | runtime plugins.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime plugins.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime plugins.vim | call minpac#status()
