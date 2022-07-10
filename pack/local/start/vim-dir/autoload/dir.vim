vim9script

import autoload './popup.vim'


def FmtPerm(e: dict<any>): string
    return (e.type == 'file' ? '-' : e.type[0]) .. e.perm
enddef


def FmtName(e: dict<any>): string
    return e.name .. (e.type =~ 'link' ? ' -> ' .. resolve(e.name) : '')
enddef


def FmtTime(t: number): string
    return (e.type == 'file' ? '-' : e.type[0]) .. e.perm
enddef


def FmtSize(s: number): string
    if s >= 10 * 1073741824
        return $"{s / 1073741824}G"
    elseif s >= 10 * 1048576
        return $"{s / 1048576}M"
    elseif s >= 1048576
        return $"{s / 1024}K"
    else
        return $"{s}"
    endif
enddef

def FileForSearch(v: string): string
    return '\s\zs' .. escape(v, '~$.') .. '\($\| ->\)'
enddef


def PrintDir(dir: list<dict<any>>)
    setl ma nomod noro
    sil! :%d _
    setline(1, b:dir_cwd)
    var strdir = []
    if has("win32")
        strdir = dir->mapnew(
                      (_, v) => printf("%s %6s %s %s",
                          FmtPerm(v), FmtSize(v.size),
                          strftime("%Y-%m-%d %H:%M", v.time),
                          v.name))
    else
        strdir = dir->mapnew(
                      (_, v) => printf("%s %-8s %-8s %6s %s %s",
                          FmtPerm(v), v.user, v.group, FmtSize(v.size),
                          strftime("%Y-%m-%d %H:%M", v.time),
                          FmtName(v)))
    endif
    if len(strdir) > 0
        setline(2, [""] + strdir)
    endif
    setl noma nomod ro
enddef


def ReadDir(name: string): list<dict<any>>
    var path = resolve(name)
    var dirs = readdirex(path, (v) => v.type =~ 'dir\|junction\|linkd')
    var files = readdirex(path, (v) => v.type =~ 'file\|link$')
    return dirs + files
enddef


export def Open(name: string = '', mod: string = '')
    var oname = (expand(name)
                ?? get(b:, "dir_cwd", '')
                ?? expand("%:p:h"))->substitute('\', '/', 'g')
    var maybe_focus = ""
    if (&ft != 'dir' && filereadable(expand("%"))) ||
        (&ft == 'dir' && len(oname) < len(get(b:, "dir_cwd", "")) && isdirectory($"{oname}/{expand('%:t')}"))
        maybe_focus = expand("%:t")
    endif

    if oname =~ './$' && oname !~ '^\u:/$'
        oname = oname->trim('/', 2)
    endif
    if !isabsolutepath(oname)
        oname = simplify($"{getcwd()}/{oname}")
    endif

    if !empty(mod)
        exe $"{mod}"
    endif

    if isdirectory(oname)
        var new_bufname = $"dir://{oname}"
        if &hidden
            if new_bufname->bufexists()
                exe $"sil! keepj keepalt b {new_bufname}"
            else
                enew
            endif
        elseif &modified && new_bufname->bufexists()
            exe $"sil! keepj keepalt sb {new_bufname}"
        elseif new_bufname->bufexists()
            exe $"sil! keepj keepalt b {new_bufname}"
        elseif &modified
            new
        else
            enew
        endif
        set ft=dir
        set buftype=acwrite
        set bufhidden=unload
        set nobuflisted
        set noswapfile

        exe $"sil! keepj keepalt file {new_bufname}"
        exe $"lcd {oname}"
        b:dir = ReadDir(oname)
        b:dir_cwd = oname
        PrintDir(b:dir)
        norm! j
        norm! $2F/l
        if empty(maybe_focus)
            if len(b:dir) > 0
                search(FileForSearch(b:dir[0].name))
            endif
        else
            search(FileForSearch(maybe_focus))
        endif
    else
        exe $"e {oname}"
    endif
enddef


export def Action(mod: string = '')
    if line('.') == 1
        var new_dir = getline(1)[0 : searchpos('/\|$', 'c', 1)[1] - 1]
        if isdirectory(new_dir)
            Open(new_dir, mod)
        endif
    else
        var idx = line('.') - 3
        if idx < 0 | return | endif
        var cwd = trim(b:dir_cwd, '/', 2)
        Open($"{cwd}/{b:dir[idx].name}", mod)
    endif
enddef


export def ActionUp()
    Open(fnamemodify(b:dir_cwd, ":h"))
enddef


export def ActionPreview()
    var idx = line('.') - 3
    if idx < 0 | return | endif
    var cwd = trim(b:dir_cwd, '/', 2)
    if filereadable($"{cwd}/{b:dir[idx].name}")
        popup.Show(readfile($"{cwd}/{b:dir[idx].name}", "", 100), $"{b:dir[idx].name}")
    endif
enddef
