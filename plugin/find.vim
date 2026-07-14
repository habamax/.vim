vim9script

var files_cache: list<string> = []

def FindCmd(): string
    var cmd = ''
    if executable('fd')
        cmd = 'fd . --path-separator / --type f --hidden --follow --exclude .git'
    elseif executable('fdfind')
        cmd = 'fdfind . --path-separator / --type f --hidden --follow --exclude .git'
    elseif executable('ugrep')
        cmd = 'ugrep "" -Rl -I --ignore-files'
    elseif executable('rg')
        cmd = 'rg --path-separator / --files --hidden --glob !.git'
    elseif executable('find')
        cmd = 'find \! \( -path "*/.git" -prune -o -name "*.swp" \) -type f -follow'
    endif
    return cmd
enddef

def Find(arg: string, _): list<string>
    if empty(files_cache)
        au CmdlineEnter : ++once files_cache = []
        var cmd = FindCmd()
        if empty(cmd)
            files_cache = expand('**', 1, 1)
                ->filter((_, v) => !isdirectory(v))
                ->mapnew((_, v) => v->substitute('^\.[\/]', "", ""))
        else
            files_cache = systemlist(cmd)
        endif
    endif
    if empty(arg)
        return files_cache
    else
        return files_cache->matchfuzzy(arg)
    endif
enddef

set findfunc=Find
