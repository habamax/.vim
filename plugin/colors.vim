vim9script

if !has('win32') && !has('gui_running')
        && $TERM !~ 'xterm'
        && has('termguicolors')
    &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

def Habamax()
    if !has("gui_running")
        hi Normal guibg=NONE ctermbg=NONE
    endif
    if has("gui_running") || &termguicolors
        hi DiffAdd guibg=#002f00 guifg=NONE gui=NONE cterm=NONE
        hi DiffChange guibg=#1f2f3f guifg=NONE gui=NONE cterm=NONE
        hi DiffDelete guibg=#3f1f00 guifg=#585858 gui=NONE cterm=NONE
    else
        hi DiffAdd cterm=reverse
        hi DiffChange cterm=reverse
        hi DiffDelete cterm=reverse
    endif
enddef

augroup colors | au!
    au Colorscheme * hi link lspDiagSignErrorText Removed
    au Colorscheme * hi link lspDiagVirtualTextError Removed
    au Colorscheme * hi link lspDiagSignWarningText Changed
    au Colorscheme * hi link lspDiagVirtualTextWarning Changed
    au Colorscheme habamax Habamax()
    au Colorscheme habamax,xamabah hi VertSplit guibg=NONE ctermfg=NONE
augroup END

g:colors = ["habamax", "xamabah"]
if has("win32") && has("gui_running")
    exe "silent! colorscheme" g:colors[1]
else
    exe "silent! colorscheme" g:colors[0]
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
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu.vim
command! ColoPopuKind  tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu_kind.vim
command! ColoSpell tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_spell.vim
