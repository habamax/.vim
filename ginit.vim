if exists("g:neovide")
    set guifont=Iosevka\ Habamax:h20
else
    GuiLinespace 0
    GuiPopupmenu 0 
    GuiFont! Iosevka\ Habamax:h14

    nnoremap <silent> <C-6> <C-^>
    inoremap <silent> <C-6> <C-^>
endif

