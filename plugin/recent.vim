vim9script

const recent_file = $'{$MYVIMDIR}.data/mru.json'
const recent_max_count = 100
const recent_ft_avoid = ['gitcommit']
var mru: dict<any> = {}

augroup Recent
    au!
    au BufEnter * Add()
    au QuitPre * Save()
    au CursorHold * Save()
augroup END

def Read(reset: bool = false)
    if filereadable(recent_file)

        if reset
            mru = readfile(recent_file)
                ->join()
                ->json_decode()
                ->filter((k, _) => filereadable(expand(k)))
            return
        endif

        # Merging in memory and in file recent files.
        # Ineffective, but the recent files count should be relatively small
        var new_mru = readfile(recent_file)
            ->join()
            ->json_decode()
            ->filter((k, _) => filereadable(expand(k)))
            ->extendnew(mru, 'keep')

        for [k, v] in items(new_mru)
            var ts = get(mru, k, 0)
            new_mru[k] = v > ts ? v : ts
        endfor

        # Remove >max_count entries.
        # 1. Convert to list and sort by timestamp
        # 2. Take first max_count entries
        # 3. Convert back to dict
        for [k, v] in items(new_mru)
                ->sort((v1, v2) => v1[1] == v2[1] ? 0 : v1[1] < v2[1] ? 1 : -1)
                ->slice(0, recent_max_count - 1)
            mru[k] = v
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

def RecentComplete(arg: string, _, _): list<dict<any>>
    Read()
    var mru_list = mru
        ->items()
        ->sort((v1, v2) => v1[1] == v2[1] ? 0 : v1[1] < v2[1] ? 1 : -1)
        ->map((_, v) => (
        {
            word: v[0],
            abbr: fnamemodify(v[0], ":."),
            menu: DateDiffToText(v[1])
        }))

    if mru_list->len() > 0 && expand(mru_list[0].word) == expand("%:p")
        mru_list = mru_list[1 : ]
    endif

    if empty(arg)
        return mru_list
    else
        return mru_list->matchfuzzy(arg, {key: "word"})
    endif
enddef

def DateDiffToText(dt: number): string
    var now = localtime()
    var diff = now - dt
    if diff < 60
        return printf("just now", diff)
    elseif diff < 3600
        var d = diff / 60
        return printf("%d min%s", d, d > 1 ? 's' : '')
    elseif diff < 3600 * 24
        var d = diff / 3600
        return printf("%d hour%s", d, d > 1 ? 's' : '')
    elseif diff < 3600 * 24 * 7
        var d = diff / (3600 * 24)
        return printf("%d day%s", d, d > 1 ? 's' : '')
    elseif diff < 3600 * 24 * 7 * 4
        var d = diff / (3600 * 24 * 7)
        return printf("%d week%s", d, d > 1 ? 's' : '')
    elseif diff < 3600 * 24 * 7 * 4 * 12
        var d = diff / (3600 * 24 * 7 * 4)
        return printf("%d month%s", d, d > 1 ? 's' : '')
    else
        var d = diff / (3600 * 24 * 365)
        return printf("%d year%s", d, d > 1 ? 's' : '')
    endif
enddef


command! -nargs=_ -complete=customlist,RecentComplete Recent Edit(<q-args>, false, <q-mods>)
command! -nargs=_ -complete=customlist,RecentComplete SRecent Edit(<q-args>, true, <q-mods>)
command! RecentReset Read(true)
