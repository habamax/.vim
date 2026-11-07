vim9script

if !has('gui_running')
    set termguicolors
endif

def Lsp()
    hi link LspHighlightWrite LspHighlightRead
    hi link LspDiagError Removed
enddef

def Undercurl()
    if has("gui_runnign") || !exists("WSL_DISTRO_NAME")
        return
    endif
    if g:colors_name == 'habamax'
        hi SpellBad guifg=NONE guibg=NONE guisp=#d75f5f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=167
        hi SpellCap guifg=NONE guibg=NONE guisp=#ffaf5f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=215
        hi SpellLocal guifg=NONE guibg=NONE guisp=#5fd75f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=77
        hi SpellRare guifg=NONE guibg=NONE guisp=#d787d7 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=176
    elseif g:colors_name == 'xamabah'
        hi SpellBad guifg=NONE guibg=NONE guisp=#d70000 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=160
        hi SpellCap guifg=NONE guibg=NONE guisp=#af5f00 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=130
        hi SpellLocal guifg=NONE guibg=NONE guisp=#008700 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=28
        hi SpellRare guifg=NONE guibg=NONE guisp=#af00af gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl term=underline ctermul=127
    endif
enddef

def TermNoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

augroup colors | au!
    au Colorscheme polukate,habamax TermNoBg()
    au Colorscheme * Undercurl()
    au Colorscheme * Lsp()
augroup END

g:colors = {
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
