vim9script


# termguicolors support
if !has('win32') && !has('gui_running')
        && $TERM !~ 'xterm'
        && has('termguicolors')
    &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors


def ColorschemeBase()
    var hl = hlget('LineNr')[0]
    hlset([{
        name: 'CursorLineNr',
        ctermbg: hl->has_key('ctermbg') ? hl.ctermbg : 'NONE',
        guibg: hl->has_key('guibg') ? hl.guibg : 'NONE',
        gui: {bold: true}, cterm: {bold: true}
    }])
enddef


def ColorschemeRePire()
    if has("gui_running") == 0 && &t_Co->str2nr() < 256
        return
    endif
    if &background == 'dark'
        hi Normal      ctermbg=NONE guibg=#1c1c1c
        hi TablineSel  ctermbg=NONE guibg=#1c1c1c
        hi Folded      ctermbg=233 guibg=#121212
        hi Cursorline  ctermbg=236 guibg=#303030
        hi Pmenu       ctermbg=237 guibg=#3a3a3a
        hi PmenuSel    ctermbg=214 guifg=#000000 guibg=#ffaf00
        hi ColorColumn ctermfg=16  ctermbg=233    guibg=#121212
    else
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


def ColorschemeReQuiet()
    if has("gui_running") == 0 && &t_Co->str2nr() < 256
        return
    endif
    if &background == 'dark'
        hi String      ctermfg=41   guifg=#00d75f
        hi Constant    ctermfg=204  guifg=#ff5f87
        hi rstDirective ctermfg=99   guifg=#875fff
    else
        hi String   ctermfg=28  guifg=#008700
        hi Constant ctermfg=124 guifg=#af0000
        hi rstDirective ctermfg=93  guifg=#8700ff
    endif
    hi Comment   ctermfg=243  guifg=#767676 gui=NONE cterm=NONE
    hi Title     cterm=bold   gui=bold
    hi Directory cterm=bold   gui=bold
    hi! link SpecialKey NonText
    hi! link EndOfBuffer NonText
enddef


augroup colorschemes | au!
    au Colorscheme * ColorschemeBase()
    # au Colorscheme pire ColorschemeRePire()
    au Colorscheme quiet ColorschemeReQuiet()
augroup END


if has("gui_running")
    set background=light
else
    set background=dark
endif
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
