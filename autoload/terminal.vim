vim9script

# To be used with plugin/terminal.vim
# functions to navigate error like lines, e.g somefile:20:10: error message
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
    # make[1]: Entering directory '/home/habamax/prj/vim/src'
    # make[1]: Leaving directory '/home/habamax/prj/vim/src'
    var path = $"{getcwd()}/"
    var linenr = line('.')
    while linenr > 0
        var line = getline(linenr)
        var pathm = line->matchlist('^\s*make\[\d\+\]: Entering directory ''\(\S\+\)''$')
        if !empty(pathm)
            path = $"{pathm[1]}/"
            break
        endif
        if line =~ '^\s*make\[\d\+\]: Leaving directory .\{-}$'
            break
        endif
        linenr = prevnonblank(linenr - 1)
    endwhile

    # Windows has : in `isfname` thus for ./filename:20:10: gf can't find filename cause
    # it sees filename:20:10: instead of just filename
    # So the "hack" would be:
    # - take <cWORD> or a line under cursor
    # - extract file name, line, column
    # - edit file name

    # python
    var fname = getline('.')->matchlist('^\s\+File "\(.\{-}\)", line \(\d\+\)')

    # erlang escript
    if empty(fname)
        fname = getline('.')->matchlist('^\s\+in function\s\+.\{-}(\(.\{-}\), line \(\d\+\))')
    endif

    # rust
    if empty(fname)
        fname = getline('.')->matchlist('^\s\+--> \(.\{-}\):\(\d\+\):\(\d\+\)')
    endif

    # regular filename:linenr:colnr:
    if empty(fname)
        fname = getline('.')->matchlist('^\(\f\{-}\):\(\d\+\):\(\d\+\):.*')
    endif

    # regular filename:linenr:
    if empty(fname)
        fname = getline('.')->matchlist('^\(\f\{-}\):\(\d\+\):\?.*')
    endif

    # regular filename:
    if empty(fname)
        fname = getline('.')->matchlist('^\(\f\{-}\):.*')
    endif

    if empty(fname)
        return
    endif

    var fullname = (isabsolutepath(fname[1]) ? "" : path) .. fname[1]
    if filereadable(fullname)
        try
            var should_split = false
            var buffers = getbufinfo()->filter((_, v) => v.name == fnamemodify(fullname, ":p"))
            fullname = fullname->escape('#&%\')
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
                    exe $"{vertical}sbuffer {fullname}"
                else
                    exe $"{vertical}split {fullname}"
                endif
            else
                if len(buffers) > 0
                    exe $"buffer {fullname}"
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
                wincmd p
            endif
        catch
        endtry
    endif
enddef

export def NextError()
    var rxError = '^\f\{-}:\d\+\(:\d\+:\?\)\?'
    var rxPyError = '^\s*File ".\{-}", line \d\+,'
    var rxErlEscriptError = '^\s\+in function\s\+.\{-}(.\{-}, line \d\+)'
    if search($'\({rxError}\)\|\({rxPyError}\)\|\({rxErlEscriptError}\)', 'W') > 0
        OpenError(true)
    endif
enddef

export def PrevError()
    var rxError = '^\f\{-}:\d\+\(:\d\+:\?\)\?'
    var rxPyError = '^\s*File ".\{-}", line \d\+,'
    var rxErlEscriptError = '^\s\+in function\s\+.\{-}(.\{-}, line \d\+)'
    if search($'\({rxError}\)\|\({rxPyError}\)\|\({rxErlEscriptError}\)', 'bW') > 0
        OpenError(true)
    endif
enddef
