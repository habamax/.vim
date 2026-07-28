vim9script

if !has('gui_running')
    set termguicolors
endif

def Lsp()
    hi link lspDiagVirtualTextError   Removed
    hi link lspSigActiveParameter     PreProc
    hi link lspDiagSignErrorText      Removed
    hi link lspDiagVirtualTextWarning Changed
    hi link lspDiagSignWarningText    Changed
    hi link lspDiagVirtualTextHint    Added
    hi link lspDiagSignHintText       Added
    hi link lspDiagVirtualTextInfo    Question
    hi link lspDiagSignInfoText       Question
enddef

def NoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

def Default()
    if &background == 'light'
        hi Normal        guifg=#000000 guibg=#ffffff gui=NONE ctermfg=16   ctermbg=15
        hi Search        guifg=NONE    guibg=#e7f3e7 gui=NONE ctermfg=28   ctermbg=231  cterm=NONE
        hi IncSearch     guifg=NONE    guibg=#fff0cf gui=NONE ctermfg=172  ctermbg=231  cterm=NONE
        hi Pmenu         guifg=NONE    guibg=#e4e4e4 gui=NONE ctermfg=NONE ctermbg=254  cterm=NONE
        hi PmenuBorder   guifg=#808080 guibg=#e4e4e4 gui=NONE ctermfg=240  ctermbg=254  cterm=NONE
        hi PmenuExtra    guifg=#808080 guibg=#e4e4e4 gui=NONE ctermfg=240  ctermbg=254  cterm=NONE
        hi PmenuExtraSel guifg=#808080 guibg=#c6c6c6 gui=NONE ctermfg=240  ctermbg=251  cterm=NONE
        hi PmenuKind     guifg=#808080 guibg=#e4e4e4 gui=NONE ctermfg=160  ctermbg=254  cterm=NONE
        hi PmenuKindSel  guifg=#808080 guibg=#c6c6c6 gui=NONE ctermfg=160  ctermbg=251  cterm=NONE
        hi PmenuMatch    guifg=#000000 guibg=NONE    gui=bold ctermfg=16   ctermbg=NONE cterm=bold
        hi PmenuMatchSel guifg=#000000 guibg=NONE    gui=bold ctermfg=16   ctermbg=NONE cterm=bold
        hi PmenuSbar     guifg=NONE    guibg=NONE    gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
        hi PmenuSel      guifg=NONE    guibg=#c6c6c6 gui=NONE ctermfg=NONE ctermbg=251  cterm=NONE
        hi PmenuShadow   guifg=#808080 guibg=#303030 gui=NONE ctermfg=240  ctermbg=236  cterm=NONE
        hi PmenuThumb    guifg=NONE    guibg=#808080 gui=NONE ctermfg=NONE ctermbg=240  cterm=NONE
        hi Popup         guifg=NONE    guibg=#e4e4e4 gui=NONE ctermfg=NONE ctermbg=254  cterm=NONE
        hi PopupBorder   guifg=#8a8a8a guibg=#e4e4e4 gui=NONE ctermfg=245  ctermbg=254  cterm=NONE
        hi PopupTitle    guifg=#808080 guibg=#e4e4e4 gui=bold ctermfg=240  ctermbg=254  cterm=bold
        hi Visual        guifg=NONE    guibg=#bfdfff gui=NONE ctermfg=32   ctermbg=231  cterm=NONE
        hi LineNr        guifg=#a8a8a8 guibg=NONE    gui=NONE ctermfg=248  ctermbg=NONE cterm=NONE
        hi SignColumn    guifg=#a8a8a8 guibg=NONE    gui=NONE ctermfg=248  ctermbg=NONE cterm=NONE
        hi FoldColumn    guifg=#a8a8a8 guibg=NONE    gui=NONE ctermfg=248  ctermbg=NONE cterm=NONE
        hi QuickFixLine  guifg=NONE    guibg=#e7cfe7 gui=NONE ctermfg=16   ctermbg=182  cterm=NONE
        hi MatchParen    guifg=#ff00af guibg=NONE    gui=bold ctermfg=199  ctermbg=NONE cterm=bold
        hi CursorColumn  guifg=NONE    guibg=#eeeeee gui=NONE ctermfg=NONE ctermbg=255  cterm=NONE
        hi CursorLine    guifg=NONE    guibg=#eeeeee gui=NONE ctermfg=NONE ctermbg=255  cterm=NONE
        hi CursorLineNr  guifg=#000000 guibg=NONE    gui=bold ctermfg=16   ctermbg=NONE cterm=bold
        hi NonText       guifg=#a8a8a8 guibg=NONE    gui=NONE ctermfg=248  ctermbg=NONE cterm=NONE
        hi SpecialKey    guifg=#a8a8a8 guibg=NONE    gui=NONE ctermfg=248  ctermbg=NONE cterm=NONE
        hi TitleBar      guifg=#000000 guibg=#ececec gui=NONE ctermfg=16   ctermbg=255  cterm=NONE
        hi TitleBarNC    guifg=#808080 guibg=#f5f5f5 gui=NONE ctermfg=240  ctermbg=255  cterm=NONE
        hi VertSplit     guifg=#000000 guibg=#000000 ctermfg=16 ctermbg=16
        hi VertSplitNC   guifg=#878787 guibg=#878787 ctermfg=102 ctermbg=102
        hi StatusLineNC  guifg=#ffffff guibg=#878787 gui=NONE ctermfg=16   ctermbg=252  cterm=NONE
        hi TabLineFill   guifg=NONE    guibg=#878787 gui=NONE ctermfg=16   ctermbg=252  cterm=NONE
        hi Title         guifg=NONE    guibg=NONE    gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
        hi DiffAdd       guifg=NONE    guibg=#dafada gui=NONE ctermfg=16   ctermbg=151  cterm=NONE
        hi DiffChange    guifg=NONE    guibg=#e3e3e3 gui=NONE ctermfg=16   ctermbg=253  cterm=NONE
        hi DiffDelete    guifg=#808080 guibg=#ffd7d7 gui=NONE ctermfg=240  ctermbg=224  cterm=NONE
        hi DiffText      guifg=NONE    guibg=#bfe7e7 gui=NONE ctermfg=16   ctermbg=152  cterm=NONE
        hi Todo                                      gui=bold                           cterm=bold
        hi Statement                                                                    cterm=bold
        hi Type                                                                         cterm=bold
    endif
enddef

def Wildcharm()
    hi Statement gui=bold cterm=bold
enddef

def Habamax()
    if &background == 'dark'
        if has("gui_running")
            hi Normal guibg=#1c1c26
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
    endif
enddef

augroup colors | au!
    au Colorscheme * Lsp()
    au Colorscheme habamax Habamax()
    au Colorscheme default Default()
    au Colorscheme wildcharm Wildcharm()
    au Colorscheme polukate,habamax,wildcharm,lunaperche NoBg()
    au Colorscheme * hi CursorLineNr guibg=NONE gui=bold cterm=bold
augroup END

g:colors = {
    dark: "sil! colo polukate",
    light: "set bg=light | colo wildcharm",
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
