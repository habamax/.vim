vim9script

# insert mode completion
set completepopup=highlight:Pmenu
set completeopt=popup,fuzzy
set autocomplete
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,u^3,t^5,i^5
set complete+=Fcompletor#Abbrev^3
set complete+=Fcompletor#Register^5
set complete^=Fcompletor#Lsp^10


# command line completion
set wildmode=noselect:lastused,full
set wildmenu wildoptions=pum,fuzzy pumheight=12
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
    var cmd = info.cmdline_orig->split()
    if getcmdcompltype() == 'command' && cmd->len() == 1
        return
    endif

    var commands = [
        'fin%[d]', 'b%[uffer]', 'bd%[elete]', 'colo%[rscheme]',
        'Recent', 'Bookmark', 'Project', 'Help',
        'LoadSession', 'InsertTemplate', 'Colorscheme'
    ]
    if !commands->reduce((acc, val) => acc || match(info.cmdline_orig, $'\v\C^\s*{val}\s') != -1, false)
        return
    endif

    if !empty(info.matches) && info.selected == -1 && info.pum_visible
        setcmdline($'{cmd[0]} {info.matches[0]}')
    endif
    if cmd->len() == 1
        return
    endif
enddef

augroup CmdComplete
    au!
    autocmd CmdlineChanged : {
        if !((has("win32") || exists("$WSLENV")) && fullcommand(getcmdline()) =~ '^!')
            wildtrigger()
        endif
    }
    autocmd CmdlineEnter : doautocmd User CmdCompleteReset
    autocmd CmdlineLeavePre : CmdCompleteSelectFirst()
augroup END
