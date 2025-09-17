vim9script

# To be used with plugin/terminal.vim
# functions to navigate error like lines, e.g somefile:20:10: error message

const rxError = '\v^(\f{-}):(\d+:)?(\d+:)?'
const rxPyError = '\v^\s+File "(\f{-})", line (\d+)'
const rxErlEscriptError = '\v^\s+in function\s+.{-}\((.{-}), line (\d+)\)'
const rxRustError = '\v^\s+--\> (.{-}):(\d+):(\d+)'
const rxRgUgDefault = '\v^\s*(\d+):'

def FindOtherWin(): number
    var result = -1
    var winid = win_getid()
    for wnd in range(1, winnr('$'))
        if win_getid(wnd) != winid
            result = win_getid(wnd)
            break
        endif
    endfor
    return result
enddef

export def OpenError(view: bool = false)
    var sep = has('win32') ? '\' : '/'
    var path = $"{getcwd()}{sep}"

    # simple detection of make change of directory
    # XXX: this might need an improvement.
    # make[1]: Entering directory '/home/habamax/prj/vim/src'
    # make[1]: Leaving directory '/home/habamax/prj/vim/src'
    var linenr = line('.')
    while linenr > 0
        var line = getline(linenr)
        var pathm = line->matchlist('^\s*make\[\d\+\]: Entering directory ''\(\S\+\)''$')
        if !empty(pathm)
            path = $"{pathm[1]}{sep}"
            break
        endif
        if line =~ '^\s*make\[\d\+\]: Leaving directory .\{-}$'
            break
        endif
        linenr = prevnonblank(linenr - 1)
    endwhile


    var fname = []
    for rx in [rxPyError, rxErlEscriptError, rxRustError, rxError, rxRgUgDefault]
        fname = getline('.')->matchlist(rx)
        if !empty(fname)
            break
        endif
    endfor

    if empty(fname)
        return
    endif

    # maybe default output of ripgrep(rg) or ugrep(ug)
    if fname[1] =~ '^\d\+$'
        var nr = line("'{")
        var rgFileName = getline(nr + (nr == 1 ? 0 : 1))
        if rgFileName =~ '^\f\+$'
            fname[2] = fname[1]
            fname[1] = rgFileName
        endif
    endif

    var fullname = (isabsolutepath(fname[1]) ? "" : path) .. fname[1]
    if filereadable(fullname)
        try
            var should_split = false
            var buffers = getbufinfo()->filter((_, v) => v.name == fnamemodify(fullname, ":p"))
            fullname = fullname->escape('#&%')
            if len(buffers) > 0 && len(buffers[0].windows) > 0
                win_gotoid(buffers[0].windows[0])
            elseif win_gotoid(FindOtherWin())
                if !&hidden && &modified
                    should_split = true
                endif
            else
                should_split = true
            endif

            if should_split
                var vertical = winwidth(winnr()) * 0.3 > winheight(winnr()) ? "vertical " : ""
                if len(buffers) > 0
                    exe $"silent {vertical}sbuffer {fullname}"
                    set buflisted
                else
                    exe $"{vertical}split {fullname}"
                endif
            else
                if len(buffers) > 0
                    exe $"silent buffer {fullname}"
                    set buflisted
                else
                    exe $"edit {fullname}"
                endif
            endif

            if !empty(fname[2])
                exe $":{fname[2]}"
                exe "normal! 0"
            endif

            if !empty(fname[3]) && fname[3]->str2nr() > 1
                exe $"normal! {fname[3]->str2nr() - 1}l"
            endif
            normal! zz
            if exists(":BlinkLine") == 2
                BlinkLine
            endif
            if view
                silent wincmd p
            endif
        catch
        endtry
    endif
enddef

export def NextError()
    for rx in [rxError, rxPyError, rxErlEscriptError, rxRustError, rxRgUgDefault]
        if search(rx, 'W') > 0
            OpenError(true)
            return
        endif
    endfor
enddef

export def PrevError()
    for rx in [rxError, rxPyError, rxErlEscriptError, rxRustError, rxRgUgDefault]
        if search(rx, 'bW') > 0
            OpenError(true)
            return
        endif
    endfor
enddef
