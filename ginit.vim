if exists("g:neovide")
    let g:neovide_fullscreen=v:true
    silent! source <sfile>:h/gvimrc
else
    GuiLinespace 0
    GuiPopupmenu 0 
    GuiFont! Iosevka\ Habamax:h14

    nnoremap <silent> <C-6> <C-^>
    inoremap <silent> <C-6> <C-^>
endif

