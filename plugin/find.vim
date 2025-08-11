vim9script

var files_cache: list<string> = []

export def CompleteReset()
    files_cache = []
enddef

def RgFind(cmd_arg: string, cmd_complete: bool): list<string>
    if empty(files_cache)
        files_cache = systemlist($'rg --path-separator / --files --hidden --glob !.git')
    endif
    if empty(cmd_arg)
        return files_cache
    else
        return files_cache->matchfuzzy(cmd_arg)
    endif
enddef

set findfunc=RgFind
