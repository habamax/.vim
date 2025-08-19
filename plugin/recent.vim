vim9script

const recent_file = $'{$MYVIMDIR}.data/mru'
const recent_max_count = 300
const recent_ft_avoid = ['gitcommit']

var recent_cache = []
augroup Recent
    au!
    au CmdlineEnter : recent_cache = []
    au BufEnter * Add()
augroup END

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

    var mru: list<string> = []
    if filereadable(recent_file)
        mru = readfile(recent_file)
            ->filter((_, v) => filereadable(expand(v)))
    endif

    var idx = mru->index(buf)
    if idx > -1
        mru->remove(idx)
    endif
    mru->insert(buf, 0)
    writefile(mru[ : recent_max_count], recent_file)
enddef

def Edit(filename: string)
    var fname = expand(filename)
    if !filereadable(fname)
        echom $"Can't open {fname}"
        return
    endif
    exe $"edit {fname}"
enddef

def RecentComplete(_, _, _): string
    if filereadable($'{$MYVIMDIR}.data/mru') && empty(recent_cache)
        recent_cache = readfile($'{$MYVIMDIR}.data/mru')
            ->filter((_, v) => filereadable(expand(v)))
    endif
    if recent_cache->len() > 0 && expand(recent_cache[0]) == expand("%:p")
        recent_cache = recent_cache[1 : ]
    endif
    return recent_cache->join("\n")
enddef

command! -nargs=1 -complete=custom,RecentComplete Recent Edit(<f-args>)
