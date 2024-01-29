vim9script


# termguicolors support
# if !has('win32') && !has('gui_running')
#         && $TERM !~ 'xterm'
#         && has('termguicolors')
#     &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
#     &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
# endif
# set termguicolors

def Lsp()
    if &background == "dark"
        hi lspDiagVirtualTextError ctermfg=131 cterm=NONE guifg=#af5f5f gui=NONE
        hi link lspDiagSignErrorText lspDiagVirtualTextError
        hi lspDiagVirtualTextWarning ctermfg=136 guifg=#af8700 cterm=NONE gui=NONE
        hi link lspDiagSignWarningText lspDiagVirtualTextWarning
        hi lspDiagVirtualTextHint ctermfg=107 guifg=#87af5f cterm=NONE gui=NONE
        hi link lspDiagSignHintText lspDiagVirtualTextHint
        hi lspDiagVirtualTextInfo ctermfg=31 guifg=#0087df cterm=NONE gui=NONE
        hi link lspDiagSignInfoText lspDiagVirtualTextInfo
    endif
enddef

def Misc()
    hi VertSplit ctermbg=NONE guibg=NONE
enddef

augroup colorschemes | au!
    au Colorscheme habamax,wildcharm Lsp()
    au Colorscheme habamax,wildcharm Misc()
augroup END

# set background=dark
# silent! colorscheme wildcharm
silent! colorscheme habamax

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
if !has("gui_running")
    command! Tco leg if &t_Co == 16 | set t_Co=256 | else | set t_Co=16 | endif
    nnoremap <F9> :set notgc<CR>:Tco<CR>:echo "t_Co =" &t_Co<CR>
endif
