vim9script

const W_THRESHOLD = 160
const MANWIDTH = 80

def Vertical(): string
    # if the overall vim width is too narrow or
    # there are >=2 vertical windows, split below
    if &columns >= W_THRESHOLD && winlayout()[0] != 'row'
        return "vertical"
    endif
    return ""
enddef

def PrepareBuffer(): number
    var bufname = '[Man]'
    var buffers = getbufinfo()->filter((_, v) => fnamemodify(v.name, ":t") == bufname)

    var bufnr = -1

    if len(buffers) > 0
        bufnr = buffers[0].bufnr
        var windows = win_findbuf(bufnr)
        if windows->len() > 0
            win_gotoid(windows[0])
        else
            exe $"botright {Vertical()} sbuffer {bufnr}"
        endif
    else
        exe $"botright {Vertical()} new"
        exe $"file {bufname}"
        bufnr = bufnr()
    endif

    setl filetype=man

    silent :%d _

    setl undolevels=-1

    clearjumps

    return bufnr
enddef

export def CaptureOutput(entry: string)
    var output = systemlist(escape($"MANWIDTH={MANWIDTH} man {entry}", '\'))
    if v:shell_error == 0
        var bufnr = PrepareBuffer()
        appendbufline(bufnr, 0, output)
        deletebufline(bufnr, "$")
        setl undolevels&
        :1
    else
        echom $"Can't open manual for '{entry}'!"
    endif
enddef

var man_pages = ""
export def Complete(_, _, _): string
    # return system("man -k . | cut -d ' ' -f1 | sort -u")
    if empty(man_pages)
        man_pages = system("man -k . | cut -d ' ' -f1 | sort -u")
    endif
    return man_pages
enddef
