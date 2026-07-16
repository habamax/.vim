vim9script

var files: list<string> = []

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
    if empty(files)
        au CmdlineEnter : ++once files = []
        var cmd = FindCmd()
        if empty(cmd)
            files = expand('**', 1, 1)->filter((_, v) => !isdirectory(v))
        else
            files = systemlist(cmd)
        endif
    endif
    return empty(arg) ? files : files->matchfuzzy(arg)
enddef

set findfunc=Find
