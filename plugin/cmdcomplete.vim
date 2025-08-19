vim9script

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
        'find', 'buffer', 'bdelete', 'colorscheme',
        'Recent', 'Bookmark', 'Project', 'Help',
        'LoadSession', 'InsertTemplate', 'Colorscheme'
    ]
    if commands->index(fullcommand(info.cmdline_orig)) == -1
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
    autocmd CmdlineLeavePre : CmdCompleteSelectFirst()
augroup END
