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

def DeQuiet()
    hi Title cterm=bold gui=bold
    hi Directory cterm=bold gui=bold
    hi Comment ctermfg=243 cterm=NONE guifg=#767676 gui=NONE
    hi CursorLineNr cterm=bold gui=bold
    if &bg == 'dark'
        # hi Normal ctermbg=234 guibg=#1c1c1c
        hi Statement ctermfg=99 guifg=#875fff
        hi Constant ctermfg=204 guifg=#ff5f87
        hi String ctermfg=35 guifg=#00af5f
        hi Identifier ctermfg=176 guifg=#d787d7
        hi PreProc ctermfg=37 guifg=#00afaf
        hi Type ctermfg=33 guifg=#0087d7
        hi Special ctermfg=172 guifg=#d78700
        hi SpecialKey ctermfg=238 cterm=NONE guifg=#444444 gui=NONE
        hi Visual ctermfg=16 ctermbg=99 cterm=NONE guifg=#000000 guibg=#875fff gui=NONE
    else
        hi Statement ctermfg=56 guifg=#5f00d7
        hi Constant ctermfg=124 guifg=#af0000
        hi String ctermfg=28 guifg=#008700
        hi Identifier ctermfg=90 guifg=#870087
        hi PreProc ctermfg=30 guifg=#008787
        hi Type ctermfg=25 guifg=#005faf
        hi Special ctermfg=130 guifg=#af5f00
        hi SpecialKey ctermfg=248 cterm=NONE guifg=#a8a8a8 gui=NONE
        hi Visual ctermfg=231 ctermbg=56 cterm=NONE guifg=#ffffff guibg=#5f00d7
    endif
enddef

augroup colorschemes | au!
    au Colorscheme habamax,wildcharm Lsp()
    au Colorscheme habamax,wildcharm Misc()
    au Colorscheme quiet DeQuiet()
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
