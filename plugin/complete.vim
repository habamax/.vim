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

def CmdCompleteSelectFirst()
    var info = cmdcomplete_info()
    if empty(get(info, 'cmdline_orig', ''))
        return
    endif
    var commands = '\v(^colo%[rscheme])|(^b%[uffer])|(^MRU)|(^LoadSession)\s'
    if match(info.cmdline_orig, commands) == -1
        return
    endif
    if !empty(get(info, 'matches', []))
        if info.selected == -1 && info.pum_visible
            setcmdline($'{info.cmdline_orig->split()[0]} {info.matches[0]}')
        endif
    endif
enddef

augroup cmdcomplete
    au!
    autocmd CmdlineChanged : wildtrigger()
    autocmd CmdlineLeavePre : CmdCompleteSelectFirst()
augroup END
