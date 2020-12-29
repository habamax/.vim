""" Use minpac:
""" 0. Clone .vim first `git clone https://github.com/habamax/.vim.git ~/.vim`
""" 1. Run :PackBoot on a fresh machine to bootstrap minpac.
""" 2. Run :PackUpdate to install plugins.
""" 3. Then from time to time run :PackUpdate to update plugins.

command! PackBoot let g:minpac_bootstrap = 1 | packadd minpac | runtime plugin/minpac.vim
command! PackUpdate packadd minpac | runtime plugin/minpac.vim | call minpac#update()
command! PackClean  packadd minpac | runtime plugin/minpac.vim | call minpac#clean()


if !exists('g:loaded_minpac')
    if exists('g:minpac_bootstrap') && executable('git')
        let vdir = expand(has("win32") ? "~/vimfiles" : "~/.vim")
        let cmd = "git clone https://github.com/k-takata/minpac.git "..vdir.."/pack/minpac/opt/minpac"
        call system(cmd)
        echom "To install plugins, run :PackUpdate"
    endif

    finish
endif


call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})



"""
""" My plugins
"""
call minpac#add('git@github.com:habamax/vim-select.git',      { 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-select-more.git', { 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-asciidoctor.git', { 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-evalvim.git',     { 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-habanight.git',   { 'rev': 'master', 'type': 'opt'})
call minpac#add('git@github.com:habamax/vim-alchemist.git',   { 'rev': 'master', 'type': 'opt'})
call minpac#add('git@github.com:habamax/vim-gruvbit.git',     { 'rev': 'master', 'type': 'opt'})
call minpac#add('git@github.com:habamax/vim-polar.git',       { 'rev': 'master', 'type': 'opt'})
call minpac#add('git@github.com:habamax/vim-godot.git',       { 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-num2words.git',   { 'rev': 'master'})
call minpac#add('git@github.com:habamax/vim-winlayout.git',   { 'rev': 'master'})
" call minpac#add('git@github.com:habamax/vim-sendtoterm.git',  { 'rev': 'master'})



"""
""" Git
"""
call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
call minpac#add('rbong/vim-flog', {'type': 'opt'})



"""
""" Text manipulation
"""
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')

" cxiw .
call minpac#add('tommcdo/vim-exchange')

call minpac#add('junegunn/vim-easy-align')

" swap comma separated stuff with `g>` `g<` `gs`
" `gs` will probably interfere with vim-sort-motion
" map it to `g.`
call minpac#add('machakann/vim-swap')



"""
""" Coding
"""
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-endwise')
call minpac#add('ludovicchabant/vim-gutentags', {'type': 'opt'})
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('vim-test/vim-test')
call minpac#add('elixir-editors/vim-elixir')
call minpac#add('aklt/plantuml-syntax')
call minpac#add('cespare/vim-toml')

call minpac#add('neoclide/coc.nvim', {'type': 'opt', 'branch': 'release'})
" after install/update run `./install.py`
" or `./install.py --go-completer` if you need go completion
call minpac#add('ycm-core/YouCompleteMe', {'type': 'opt'})
" backup general <tab> completion
call minpac#add('lifepillar/vim-mucomplete')

" Close tags with > and >> in insert mode
call minpac#add('alvan/vim-closetag')



"""
""" Miscelaneous
"""
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-eunuch')

" preview of :s command
call minpac#add('markonm/traces.vim')

" File management
call minpac#add('lambdalisue/fern.vim')

" auto cd to your project root folder
call minpac#add('airblade/vim-rooter')

call minpac#add('lifepillar/vim-colortemplate')
call minpac#add('chrisbra/Colorizer')
call minpac#add('romainl/Apprentice', {'type': 'opt'})

" call minpac#add('vim-airline/vim-airline')
" call minpac#add('itchyny/lightline.vim')
