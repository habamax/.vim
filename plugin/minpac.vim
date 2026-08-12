vim9script

command PackUpdate PackInit() | minpac#update()
command PackClean  PackInit() | minpac#clean()

def PackInit()
    minpac#init()
    minpac#add('k-takata/minpac', {type: 'opt'})

    minpac#add('git@github.com:habamax/vim-habamax.git')
    minpac#add('git@github.com:habamax/vim-polukate.git')
    minpac#add('git@github.com:habamax/vim-dir.git')
    minpac#add('git@github.com:habamax/vim-rst.git')
    minpac#add('git@github.com:habamax/vim-asciidoctor.git')
    minpac#add('git@github.com:habamax/vim-gdscript.git')
    minpac#add('git@github.com:habamax/vim-odin.git')
    minpac#add('git@github.com:habamax/vim-curl.git')
    minpac#add('markonm/traces.vim')
    minpac#add('tpope/vim-fugitive')
    minpac#add('alvan/vim-closetag')
    minpac#add('yegappan/lsp')
    minpac#add('git@github.com:vim/colorschemes.git')

    # Should be installed separately
    # :Term git clone https://codeberg.org/lifepillar/vim-devel $MYVIMDIR/pack
enddef

silent! packadd minpac

# Bootstrap minpac and plugins
if !exists("g:loaded_minpac")
    var mp_path = $'{$MYVIMDIR}pack/minpac/opt/minpac'
    system($'git clone https://github.com/k-takata/minpac.git {mp_path}')
    if v:shell_error != 0
        echow "Couldn't install minpac!"
    else
        packadd minpac
        PackUpdate
    endif
endif
