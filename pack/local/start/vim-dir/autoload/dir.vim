vim9script


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


export def Open(name: string = '', focus: string = '')
    var oname = (expand(name)
                ?? get(b:, "dir_cwd", '')
                ?? expand("%:p:h"))->substitute('\', '/', 'g')
    var maybe_focus = expand("%:t")
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
        # if empty(focus)
        #     if len(b:dir) > 0
        #         search(escape(b:dir[0].name, '~$.'))
        #     endif
        # else
        if len(maybe_focus) > len(oname)
            search(escape(maybe_focus, '~$.'))
            echom maybe_focus
        # endif
        # if empty(focus)
        #     if len(b:dir) > 0
        #         search(escape(b:dir[0].name, '~$.'))
        #     endif
        # else
        #     search(escape(focus, '~$.'))
        # endif
    else
        exe $"e {oname}"
    endif
enddef




export def Action()
    var idx = line('.') - 3
    if idx < 0 | return | endif
    var cwd = trim(b:dir_cwd, '/', 2)
    Open($"{cwd}/{b:dir[idx].name}")
enddef


export def ActionUp()
    Open(fnamemodify(b:dir_cwd, ":h"), fnamemodify(b:dir_cwd, ":t"))
enddef

