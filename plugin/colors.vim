vim9script

if !has('gui_running')
    set termguicolors
endif

def Diff()
    if &background == "dark"
        if has("gui_running") || &termguicolors
            hi DiffAdd guibg=#002f00 guifg=NONE gui=NONE cterm=NONE
            hi DiffChange guibg=#1f2f3f guifg=NONE gui=NONE cterm=NONE
            hi DiffDelete guibg=#3f1f00 guifg=#585858 gui=NONE cterm=NONE
        else
            hi DiffAdd cterm=reverse
            hi DiffChange cterm=reverse
            hi DiffDelete cterm=reverse
        endif
    endif
enddef

def NoBg()
    if has("gui_running") || &background == "light"
        return
    endif
    hi Normal guibg=NONE ctermbg=NONE
enddef

def LspDiag()
    hi link lspDiagSignErrorText Removed
    hi link lspDiagVirtualTextError Removed
    hi link lspDiagSignWarningText Changed
    hi link lspDiagVirtualTextWarning Changed
enddef

def Vsplit()
    hi VertSplit guibg=NONE ctermfg=NONE
enddef

augroup colors | au!
    au Colorscheme * LspDiag()
    au Colorscheme habamax,wildcharm,lunaperche,nod* NoBg()
    au Colorscheme habamax,wildcharm Diff()
    au Colorscheme habamax,xamabah,wildcharm,lunaperche,nod*,nope* Vsplit()
augroup END

g:colors = {
    dark: "sil! colo nod-d",
    light: "sil! colo nope-y"
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

# finish

# helper commands and mappings to work with vim/colorschemes
command! ColoCheck ru colors/tools/check_colors.vim
command! ColoMisc  tabnew | ru colors/tools/sample_misc.vim
command! ColoMess  ru colors/tools/sample_messages.vim
command! -nargs=1 -complete=color Colo exe "ru legacy_colors/" .. <q-args> .. ".vim"
command! ColoDiff  tabnew | ru colors/tools/sample_diff.vim
command! ColoQF    tabnew | ru colors/tools/sample_quickfix.vim
command! ColoTerm  tabnew | ru colors/tools/sample_terminal.vim
command! ColoWin   tabnew | ru colors/tools/sample_windows.vim
command! ColoPopu  tabnew |
      \ exe "lcd " .. $MYVIMDIR .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu.vim
command! ColoPopuKind  tabnew |
      \ exe "lcd " .. $MYVIMDIR .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu_kind.vim
command! ColoSpell tabnew |
      \ exe "lcd " .. $MYVIMDIR .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_spell.vim
