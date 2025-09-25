vim9script

if !has('gui_running')
    set termguicolors
endif

def Lsp()
    hi link lspDiagSignErrorText Removed
    hi link lspDiagVirtualTextError Removed
    hi link lspDiagSignWarningText Changed
    hi link lspDiagVirtualTextWarning Changed
enddef

def NoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

def Vsplit()
    hi VertSplit guibg=NONE ctermbg=NONE
enddef

augroup colors | au!
    au Colorscheme * Lsp()
    au Colorscheme polukate,habamax,wildcharm,lunaperche,nod* NoBg()
    au Colorscheme habamax,xamabah,wildcharm,lunaperche,nod*,nope* Vsplit()
    au Colorscheme * hi CursorLineNr guibg=NONE gui=bold cterm=bold
    au Colorscheme * hi Comment cterm=italic gui=italic
augroup END

g:colors = {
    dark: "sil! colo polukate",
    light: "set bg=light | sil! colo wildcharm",
}

# g:colors = {
#     dark: "sil! colo habamax",
#     light: "sil! colo xamabah"
# }

# g:colors = {
#     dark: "set bg=dark | sil! colo wildcharm",
#     light: "set bg=light | sil! colo wildcharm",
# }

# g:colors = {
#     dark: "set bg=dark | sil! colo lunaperche",
#     light: "set bg=light | sil! colo lunaperche",
# }

if has("win32") && has("gui_running")
    exe g:colors.light
else
    exe g:colors.dark
endif

# helper commands and mappings to work with vim/colorschemes
command! ColoMisc run colors/sample/misc.vim
command! ColoMess run colors/sample/messages.vim
command! ColoDiff run colors/sample/diff.vim
command! ColoQF run colors/sample/quickfix.vim
command! ColoPmenu run colors/sample/popupmenu.vim
command! ColoPmenuKind run colors/sample/popupmenu_kind.vim
command! ColoSpell run colors/sample/spell.vim

if !has("gui_running")
    import autoload 'qc.vim'
    nnoremap <space>cs <scriptcmd>qc.ColorSupport()<CR>
endif
