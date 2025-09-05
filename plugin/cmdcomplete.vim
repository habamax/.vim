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
    # If @: is pressed v:char is \n, exit here, allowing the command to be executed.
    # Otherwise, if command-line was cancelled, clear it and exit the function.
    if v:char == "\n"
        return
    elseif v:char != "\<CR>" && has("patch-9.1.1679")
        setcmdline('')
        return
    endif

    var info = cmdcomplete_info()
    if empty(get(info, 'cmdline_orig', ''))
            || empty(info.matches) || !info.pum_visible
        return
    endif

    var cmd = info.cmdline_orig->split()
    # Do not accept first element of completion for just commands:
    # :e<CR> should not be expanded to :edit<CR>
    if getcmdcompltype() == 'command' && cmd->len() == 1
        return
    endif

    # Do not accept first element of completion if there are multiple arguments
    if cmd->len() > 2
        return
    endif

    # Commands to accept first element of completion if no selection is made and
    # completion is visible.
    # :e newfile<CR> should always edit newfile, not the first element of completion
    var commands = [
        'sfind', 'find', 'buffer', 'sbuffer', 'bdelete',
        'colorscheme', 'highlight',
        'Buffer', 'SBuffer', 'Recent', 'SRecent', 'Bookmark', 'SBookmark',
        'Project', 'Help',
        'LoadSession', 'InsertTemplate', 'Colorscheme', 'Unicode'
    ]

    # fullcommand() can't figure out `:vertical sbuffer` or `:horizontal sbuffer`,
    var cmd_orig = substitute(info.cmdline_orig, '\v^%(%(ver%[tical])|%(hor%[izontal]))', '', '')
    var cmd_len = len(cmd_orig) == len(info.cmdline_orig) ? 0 : 1
    if commands->index(fullcommand(cmd_orig)) == -1
        return
    endif

    var selected = info.matches[info.selected == -1 ? 0 : info.selected]
    if fullcommand(cmd_orig) != "Help"
        selected = selected->escape('#%')
    endif
    setcmdline($'{cmd[ : cmd_len]->join()} {selected}')
enddef

augroup CmdComplete
    au!
    autocmd CmdlineChanged : {
        # :! completion is very slow on Windows and WSL, disable it there.
        if !((has("win32") || exists("$WSLENV")) && fullcommand(getcmdline()) =~ '^!')
            wildtrigger()
        endif
    }
    autocmd CmdlineLeavePre : CmdCompleteSelectFirst()
augroup END
