vim9script

command PackUpdate PackInit() | minpac#update()
command PackClean PackInit()  | minpac#clean()

def PackInit()
    minpac#init()
    minpac#add('k-takata/minpac', {type: 'opt'})

    minpac#add('habamax/vim-habamax')
    minpac#add('habamax/vim-polukate')
    minpac#add('habamax/vim-dir')
    minpac#add('habamax/vim-rst')
    minpac#add('habamax/vim-asciidoctor')
    minpac#add('habamax/vim-gdscript')
    minpac#add('habamax/vim-odin')
    minpac#add('habamax/vim-curl')
    minpac#add('markonm/traces.vim')
    minpac#add('tpope/vim-fugitive')
    minpac#add('alvan/vim-closetag')
    minpac#add('yegappan/lsp')
    minpac#add('vim/colorschemes')

    # Should be installed separately
    # git clone https://codeberg.org/lifepillar/vim-devel $MYVIMDIR/pack
enddef

silent! packadd minpac

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
