vim9script


# termguicolors support
if !has('win32') && !has('gui_running')
        && $TERM !~ 'xterm'
        && has('termguicolors')
    &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors


def Base()
    var hl = hlget('LineNr')[0]
    hlset([{
        name: 'CursorLineNr',
        ctermbg: hl->has_key('ctermbg') ? hl.ctermbg : 'NONE',
        guibg: hl->has_key('guibg') ? hl.guibg : 'NONE',
        gui: {bold: true}, cterm: {bold: true}
    }])
enddef


def RePire()
    if &background == 'light'
        hi Normal       guibg=#f7f7f3
        hi TablineSel   guifg=#f7f7f3
        hi Tabline      guifg=#444444 guibg=#d7d7d0
        hi StatusLineNC guifg=#444444 guibg=#d7d7d0
        hi StatusLine   guibg=#5f5f5f gui=NONE
        hi VertSplit    guibg=#d7d7d0 guifg=#d7d7d0
        hi Cursorline   guibg=#e7e7e0
        hi Folded       guibg=#fffff9
        hi ColorColumn  guibg=#fffff9
        hi PmenuSel     guifg=#ffffff guibg=#d78700
        hi Pmenu        guibg=#deded8
    endif
    hi! link vimVar Normal
enddef


def Quiet()
    hi clear Statement
    hi clear Identifier
    hi clear PreProc
    hi clear Type
    hi clear Special
enddef


augroup colorschemes | au!
    au Colorscheme * Base()
    au Colorscheme pire RePire()
    au Colorscheme pire Quiet()
augroup END


set background=dark
silent! colorscheme pire


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
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/vim/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu.vim
command! ColoSpell tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/vim/start/colorschemes" |
      \ ru colors/tools/sample_spell.vim
if !has("gui_running")
    command! Tco leg if &t_Co == 16 | set t_Co=256 | else | set t_Co=16 | endif
    nnoremap <F9> :Tco<CR>:echo "t_Co =" &t_Co<CR>
endif
