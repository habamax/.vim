vim9script

const recent_file = $'{$MYVIMDIR}.data/mru'
const recent_max_count = 300
const recent_ft_avoid = ['gitcommit']
var mru: list<string> = []

augroup Recent
    au!
    au BufEnter * Add()
    au QuitPre * Save()
    au VimEnter * Read()
augroup END

def Read()
    if filereadable(recent_file) && empty(mru)
        mru = readfile($'{$MYVIMDIR}.data/mru')
            ->filter((_, v) => filereadable(expand(v)))
    endif
enddef

def Save()
    # TODO: merge inmemory list with the file?
    if filereadable(recent_file)
        writefile(mru[ : recent_max_count], recent_file)
    endif
enddef

def Add()
    if !empty(&buftype) || empty(bufname())
        return
    endif

    if recent_ft_avoid->index(&filetype) > -1
        return
    endif

    var buf = expand("%:p")
    if !filereadable(buf)
        return
    endif

    if stridx(buf, $HOME) > -1
        buf = "~" .. buf[len($HOME) : ]
    endif

    var idx = mru->index(buf)
    if idx > -1
        mru->remove(idx)
    endif
    mru->insert(buf, 0)
enddef

def Edit(fname: string, split: bool = false, mods: string = "")
    var guess_mods = ""
    if !empty(mods)
        guess_mods = mods
    elseif split && winwidth(winnr()) * 0.3 > winheight(winnr())
        guess_mods = "vert "
    endif
    exe $"{guess_mods} {split ? "split" : "edit"} {fname->fnamemodify(':p')}"
enddef

def RecentComplete(_, _, _): string
    Read()
    if mru->len() > 0 && expand(mru[0]) == expand("%:p")
        return mru[1 : ]->join("\n")
    endif
    return mru->join("\n")
enddef

command! -nargs=1 -complete=custom,RecentComplete Recent Edit(<q-args>, false, <q-mods>)
command! -nargs=1 -complete=custom,RecentComplete SRecent Edit(<q-args>, true, <q-mods>)
