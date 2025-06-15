vim9script

if !has('gui_running')
    set termguicolors
endif

def Diff()
    if has("gui_running") || &termguicolors
        if &background == "dark"
            hi DiffAdd guibg=#002f00 guifg=NONE gui=NONE cterm=NONE
            hi DiffChange guibg=#1f2f3f guifg=NONE gui=NONE cterm=NONE
            hi DiffDelete guibg=#3f1f00 guifg=#585858 gui=NONE cterm=NONE
        else
            hi DiffAdd guibg=#dafada guifg=NONE cterm=NONE
            hi DiffChange guibg=#daeafa guifg=NONE cterm=NONE
            hi DiffDelete guibg=#fadada guifg=NONE cterm=NONE
        endif
    else
        hi DiffAdd cterm=reverse
        hi DiffChange cterm=reverse
        hi DiffDelete cterm=reverse
    endif
enddef

def NoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

def Lsp()
    hi link lspDiagSignErrorText Removed
    hi link lspDiagVirtualTextError Removed
    hi link lspDiagSignWarningText Changed
    hi link lspDiagVirtualTextWarning Changed
enddef

def Vsplit()
    hi VertSplit guibg=NONE ctermfg=NONE
enddef

augroup colors | au!
    au Colorscheme * Lsp()
    au Colorscheme habamax,wildcharm,lunaperche NoBg()
    au Colorscheme wildcharm Diff()
    au Colorscheme gvim,habamax,xamabah,wildcharm,lunaperche,nod*,nope* Vsplit()
augroup END

g:colors = {
    dark: "set bg=dark | sil! colo gvim",
    light: "set bg=light | sil! colo gvim",
}

# g:colors = {
#     dark: "sil! colo nod-b",
#     light: "sil! colo nope"
# }

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
    # colorscheme sacrebleu
else
    exe g:colors.dark
endif

# helper commands and mappings to work with vim/colorschemes
command! ColoMisc ru colors/sample/misc.vim
command! ColoMess ru colors/sample/messages.vim
command! ColoDiff ru colors/sample/diff.vim
command! ColoQF ru colors/sample/quickfix.vim
command! ColoPmenu ru colors/sample/popupmenu.vim
command! ColoPmenuKind ru colors/sample/popupmenu_kind.vim
command! ColoSpell ru colors/sample/spell.vim

if !has("gui_running")
    import autoload 'popcom.vim'
    nnoremap <space>gt <scriptcmd>popcom.ColorSupport()<CR>
endif
