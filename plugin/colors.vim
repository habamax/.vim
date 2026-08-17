vim9script

if !has('gui_running')
    set termguicolors
endif

def TermNoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

augroup colors | au!
    au Colorscheme polukate,habamax TermNoBg()
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
