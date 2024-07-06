vim9script

# if !has('win32') && !has('gui_running')
#         && $TERM !~ 'xterm'
#         && has('termguicolors')
#     &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
#     &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
# endif
# set termguicolors

if !has("gui_running")
    augroup colors_term | au!
        au Colorscheme habamax,nod,nod-b,nod-d,nod-gb hi Normal ctermbg=NONE guibg=NONE
        au Colorscheme wildcharm,retrobox if &bg == 'dark' | hi Normal ctermbg=NONE guibg=NONE | endif
    augroup END
endif
augroup colors | au!
    au Colorscheme * hi link lspDiagSignErrorText Removed
    au Colorscheme * hi link lspDiagVirtualTextError Removed
    au Colorscheme * hi link lspDiagSignWarningText Changed
    au Colorscheme * hi link lspDiagVirtualTextWarning Changed
augroup END

g:colors = ["nod", "nope"]
exe "silent! colorscheme" g:colors[0]

finish

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
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/ext/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu.vim
command! ColoPopuKind  tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/ext/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu_kind.vim
command! ColoSpell tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/ext/start/colorschemes" |
      \ ru colors/tools/sample_spell.vim
