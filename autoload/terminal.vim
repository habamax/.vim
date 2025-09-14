vim9script
# import autoload 'terminal.vim'
# xnoremap <expr> <space>t terminal.Send()
# nnoremap <expr> <space>t terminal.Send()
# nnoremap <expr> <space>tt terminal.Send() .. '_'

# handle python repl
# 1. remove indent of the first non empty line
# 2. insert empty line before top level statements
def PrepareText(text: list<string>): list<string>
    var result: list<string> = []
    if empty(text)
        return result
    endif
    var indent_remove = -1
    for line in text
        if indent_remove == -1 && line !~ '^\s*$'
            indent_remove = line->matchstr('^\s*')->len()
        endif
        var line_res = line->substitute('^\s\{' .. indent_remove .. '}', '', '')
        if line_res =~ '^$'
            line_res = ' '
        endif
        if line_res =~ '^\S' && len(result) > 0
            result->add("")
        endif
        result->add(line_res)
    endfor
    return result
enddef

export def Send(...args: list<any>): string
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif

    var terms = getwininfo()->filter((_, v) => getbufvar(v.bufnr, '&buftype') == 'terminal')
    if len(terms) < 1
        echomsg "There is no visible terminal!"
        return ""
    endif

    if len(terms) > 1
        echomsg "Too many terminals open!"
        return ""
    endif

    var term_window = terms[0].winnr

    var region_type = {line: "V", char: "v", block: "\<c-v>"}
    var text = PrepareText(getregion(getpos("'["),
                                     getpos("']"),
                                     {type: get(region_type, args[0])}))
    if len(text) > 0 && text[-1] =~ '^\s\+'
        text[-1] ..= "\r"
    endif
    term_sendkeys(winbufnr(term_window), text->join("\r") .. "\r")

    return ""
enddef

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
    var path = ""
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
        fname = getline('.')->matchlist('^\(.\{-}\):\(\d\+\):\(\d\+\).*')
    endif

    # regular filename:linenr:
    if empty(fname)
        fname = getline('.')->matchlist('^\(.\{-}\):\(\d\+\):\?.*')
    endif

    # regular filename:
    if empty(fname)
        fname = getline('.')->matchlist('^\(.\{-}\):.*')
    endif

    if empty(fname)
        return
    endif

    var fullname = path .. fname[1]
    if filereadable(fullname)
        try
            var should_split = false
            var buffers = getbufinfo()->filter((_, v) => v.name == fnamemodify(fullname, ":p"))
            fullname = fullname->substitute('#', '\\&', 'g')
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
    search($'\({rxError}\)\|\({rxPyError}\)\|\({rxErlEscriptError}\)', 'W')
enddef

export def PrevError()
    var rxError = '^\f\{-}:\d\+\(:\d\+:\?\)\?'
    var rxPyError = '^\s*File ".\{-}", line \d\+,'
    var rxErlEscriptError = '^\s\+in function\s\+.\{-}(.\{-}, line \d\+)'
    search($'\({rxError}\)\|\({rxPyError}\)\|\({rxErlEscriptError}\)', 'bW')
enddef
