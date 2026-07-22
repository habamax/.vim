vim9script

if !has('gui_running')
    set termguicolors
endif

def Lsp()
    hi link lspDiagVirtualTextError Removed
    hi link lspSigActiveParameter PreProc
    hi link lspDiagSignErrorText Removed
    hi link lspDiagVirtualTextWarning Changed
    hi link lspDiagSignWarningText Changed
    hi link lspDiagVirtualTextHint Added
    hi link lspDiagSignHintText Added
    hi link lspDiagVirtualTextInfo Question
    hi link lspDiagSignInfoText Question
enddef

def NoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

def Habamax()
    if &background == 'dark'
        if has("gui_running")
            hi Normal guibg=#1c1c26
        endif
        hi Popup guibg=#3a3a44
        hi PopupBorder guibg=#3a3a44
        hi PopupTitle guibg=#3a3a44
        hi Pmenu guibg=#3a3a44
        hi PmenuKind guibg=#3a3a44
        hi PmenuExtra guibg=#3a3a44
        hi PmenuBorder guibg=#3a3a44
        hi PmenuSel guibg=#585862
        hi PmenuKindSel guibg=#585862
        hi PmenuMatchSel guibg=#585862
        hi PmenuExtraSel guibg=#585862
        hi Comment guifg=#80808a
    endif
enddef

augroup colors | au!
    au Colorscheme * Lsp()
    au Colorscheme habamax Habamax()
    au Colorscheme polukate,habamax,wildcharm,lunaperche NoBg()
    au Colorscheme * hi CursorLineNr guibg=NONE gui=bold cterm=bold
    # au Colorscheme * hi Comment cterm=italic gui=italic
augroup END

g:colors = {
    dark: "sil! colo polukate",
    light: "set bg=light | sil! colo wildcharm",
}

# g:colors = {
#     dark: "sil! colo habamax",
#     light: "sil! colo xamabah"
# }

if has("win32") && has("gui_running")
    exe g:colors.light
else
    exe g:colors.dark
endif

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
