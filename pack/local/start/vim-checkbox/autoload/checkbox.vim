vim9script


var cbDone = '\(\s*✓\s*\)'
var cbRejected = '\(\s*✗\s*\)'


def ToggleListItem(lnum: number)
    var line = getline(lnum)
    if IsDone(line)
        exe $':{lnum}s/\({&l:formatlistpat}\){cbDone}/\1✗ /'
    elseif IsRejected(line)
        exe $':{lnum}s/\({&l:formatlistpat}\){cbRejected}/\1/'
    elseif IsListItem(line)
        exe $':{lnum}s/{&l:formatlistpat}/&✓ /'
    endif
enddef


def IsListItem(line: string): bool
    return line =~ &l:formatlistpat
enddef


def IsDone(line: string): bool
    return line =~ $'\%({&l:formatlistpat}\){cbDone}'
enddef


def IsRejected(line: string): bool
    return line =~ $'\%({&l:formatlistpat}\){cbRejected}'
enddef


export def Toggle(lnum1: number, lnum2: number)
    var save_cursor = getcurpos()
    try
        for lnum in range(lnum2, lnum1, -1)
            ToggleListItem(lnum)
        endfor
    finally
        setpos('.', save_cursor)
    endtry
enddef


# operator pending...
export def ToggleOp(...args: list<any>): string
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif
    var sel_save = &selection
    var clipboard_save = &clipboard
    &selection = "inclusive"
    &clipboard = ""

    Toggle(line("'["), line("']"))

    &selection = sel_save
    &clipboard = clipboard_save
    return ""
enddef
