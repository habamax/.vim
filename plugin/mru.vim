vim9script

const mru_file = $'{$MYVIMDIR}/.data/mru'

def Add()
    if !empty(&buftype) || ['gitcommit']->index(&filetype) > -1
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
    if filereadable(mru_file)
        mru = readfile(mru_file)
            ->filter((_, v) => filereadable(expand(v)))
    endif

    var idx = mru->index(buf)
    if idx > -1
        mru->remove(idx)
    endif
    mru->insert(buf, 0)
    writefile(mru[ : 300], mru_file)
enddef

augroup MRU
    au!
    au BufEnter * Add()
augroup END
