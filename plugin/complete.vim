vim9script

# insert mode completion
set completepopup=highlight:Pmenu
set completeopt=popup,fuzzy
set autocomplete
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,u^3
set complete+=Fcompletor#Abbrev^3
set complete+=Fcompletor#Register^5
set complete^=Fcompletor#Lsp^10


# command line completion
set wildmode=noselect:lastused,full
set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags

cnoremap <Up> <C-U><Up>
cnoremap <Down> <C-U><Down>
cnoremap <C-p> <C-U><C-p>
cnoremap <C-n> <C-U><C-n>

augroup cmdcomplete
    au!
    autocmd CmdlineChanged : wildtrigger()
augroup END
