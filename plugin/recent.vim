vim9script

const recent_file = $'{$MYVIMDIR}.data/mru'
# TODO: use recent_max_count to limit number of recent files
const recent_max_count = 300
const recent_ft_avoid = ['gitcommit']
var mru: dict<any> = {}

augroup Recent
    au!
    au BufEnter * Add()
    au QuitPre * Save()
    au VimEnter * Read()
augroup END

def Read()
    if filereadable(recent_file)
        var current_mru = deepcopy(mru)

        mru = readfile($'{$MYVIMDIR}.data/mru')
            ->join()
            ->json_decode()
            ->filter((k, _) => filereadable(expand(k)))
            ->extendnew(current_mru, 'keep')

        for [k, v] in items(mru)
            var ts = get(current_mru, k, 0)
            mru[k] = v > ts ? v : ts
        endfor
    endif
enddef

def Save()
    if filereadable(recent_file)
        Read()
        writefile([mru->json_encode()], recent_file)
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

    mru[buf] = localtime()
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
    var mru_list = mru
        ->items()
        ->sort((v1, v2) => v1[1] == v2[1] ? 0 : v1[1] < v2[1] ? 1 : -1)
        ->map((_, v) => v[0])
    if mru_list->len() > 0 && expand(mru_list[0]) == expand("%:p")
        return mru_list[1 : ]->join("\n")
    endif
    return mru_list->join("\n")
enddef

command! -nargs=1 -complete=custom,RecentComplete Recent Edit(<q-args>, false, <q-mods>)
command! -nargs=1 -complete=custom,RecentComplete SRecent Edit(<q-args>, true, <q-mods>)
