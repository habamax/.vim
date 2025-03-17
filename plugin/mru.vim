vim9script

const mru_file = $'{$MYVIMDIR}/.data/mru'
var mru: list<string> = []
var mru_needs_save = false

export def MRU(): list<string>
    return mru
enddef

def Add()
    if !empty(&buftype)
        return
    endif

    var buf = expand("%:p")

    if !filereadable(buf)
        return
    endif

    ## TODO: re read mru file if it was changed from the last read (other vim maybe updated it?)
    # if filereadable(mru_file)
    #     mru = readfile(mru_file)
    #         ->filter((_, v) => filereadable(v))
    # endif

    var idx = mru->index(buf)
    if idx > -1
        mru->remove(idx)
    endif
    mru->insert(buf, 0)
    mru_needs_save = true
enddef

def Save()
    if mru_needs_save
        mru_needs_save = false
        writefile(mru[ : 300], mru_file)
    endif
enddef

def Load()
    if empty(mru) && filereadable(mru_file)
        mru = readfile(mru_file)
            ->filter((_, v) => filereadable(v))
    endif
enddef

augroup MRU
    au!
    au VimEnter * Load()
    au CursorHold * Save()
    au VimLeavePre * Save()
    au BufEnter * Add()
augroup END
