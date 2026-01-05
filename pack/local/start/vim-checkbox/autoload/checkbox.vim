vim9script


var cbDone = '\(\s*\[[xX]\]\s*\)'
var cbTodo = '\(\s*\[ \]\s*\)'


def ToggleListItem(lnum: number)
    var line = getline(lnum)
    if IsDone(line)
        exe $':{lnum}s/\({&l:formatlistpat}\){cbDone}\s*/\1/'
    elseif IsTodo(line)
        exe $':{lnum}s/\({&l:formatlistpat}\){cbTodo}\s*/\1[x] /'
    elseif IsListItem(line)
        exe $':{lnum}s/{&l:formatlistpat}/&[ ] /'
    endif
enddef


def IsListItem(line: string): bool
    return line =~ &l:formatlistpat
enddef


def IsDone(line: string): bool
    return line =~ $'\%({&l:formatlistpat}\){cbDone}'
enddef


def IsTodo(line: string): bool
    return line =~ $'\%({&l:formatlistpat}\){cbTodo}'
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
