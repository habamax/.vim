vim9script

if !has('gui_running')
    set termguicolors
endif

def NoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

def Habamax()
    if &background == 'dark'
        if has("gui_running")
            hi Normal    guibg=#1c1c26
        endif
        hi Popup         guibg=#3a3a44
        hi PopupBorder   guibg=#3a3a44
        hi PopupTitle    guibg=#3a3a44
        hi Pmenu         guibg=#3a3a44
        hi PmenuKind     guibg=#3a3a44
        hi PmenuExtra    guibg=#3a3a44
        hi PmenuBorder   guibg=#3a3a44
        hi PmenuSel      guibg=#585862
        hi PmenuKindSel  guibg=#585862
        hi PmenuMatchSel guibg=#585862
        hi PmenuExtraSel guibg=#585862
        hi Comment       guifg=#80808a
        hi ColorColumn   guibg=#262630
        hi Statusline    guibg=#9e9ea8
        hi StatuslineNC  guibg=#767680
        hi VertSplit     guibg=#9e9ea8
        hi VertSplitNC   guibg=#767680
    endif
enddef

augroup colors | au!
    au Colorscheme habamax Habamax()
    au Colorscheme polukate,habamax,wildcharm,lunaperche NoBg()
augroup END

g:colors = {
    # dark: "sil! colo polukate",
    dark: "colo habamax",
    light: "sil! colo xamabah",
}

exe g:colors.dark

# helper commands and mappings to work with vim/colorschemes
command! ColoMisc      run colors/sample/misc.vim
command! ColoMess      run colors/sample/messages.vim
command! ColoDiff      run colors/sample/diff.vim
command! ColoQF        run colors/sample/quickfix.vim
command! ColoPmenu     run colors/sample/popupmenu.vim
command! ColoPmenuKind run colors/sample/popupmenu_kind.vim
command! ColoSpell     run colors/sample/spell.vim

if !has("gui_running")
    import autoload 'qc.vim'
    nnoremap <space>cs <scriptcmd>qc.ColorSupport()<CR>
endif
