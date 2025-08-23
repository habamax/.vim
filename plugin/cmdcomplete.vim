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
    if v:char != "\<CR>"
        return
    endif

    var info = cmdcomplete_info()
    if empty(get(info, 'cmdline_orig', ''))
        return
    endif
    var cmd = info.cmdline_orig->split()
    # Do not accept first element of completion for just commands:
    # :e<CR> should not be expanded to :edit<CR>
    if getcmdcompltype() == 'command' && cmd->len() == 1
        return
    endif

    # Commands to accept first element of completion if no selection is made and
    # completion is visible.
    # :e newfile<CR> should always edit newfile, not the first element of completion
    var commands = [
        'sfind', 'find', 'buffer', 'bdelete', 'colorscheme',
        'Recent', 'Bookmark', 'Project', 'Help',
        'LoadSession', 'InsertTemplate', 'Colorscheme', 'Unicode'
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
