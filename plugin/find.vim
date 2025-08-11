vim9script

# TODO: cache files
def RgFind(cmd_arg: string, cmd_complete: bool): list<string>
    var files = systemlist($'rg --path-separator / --files --hidden --glob !.git')
    if empty(cmd_arg)
        return files
    else
        return files->matchfuzzy(cmd_arg)
    endif
enddef

set findfunc=RgFind
