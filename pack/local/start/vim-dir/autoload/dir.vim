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
    :%d _
    setline(1, b:dir_cwd)
    var strdir = []
    if has("win32")
        strdir = dir->mapnew(
                      (_, v) => printf("%-9s %8s %s %s",
                          FmtPerm(v), FmtSize(v.size),
                          strftime("%Y-%m-%d %H:%M", v.time),
                          v.name))
    else
        strdir = dir->mapnew(
                      (_, v) => printf("%-9s %8s %-8s %8s %s %s",
                          FmtPerm(v), v.user, v.group, FmtSize(v.size),
                          strftime("%Y-%m-%d %H:%M", v.time),
                          FmtName(v)))
    endif
    if len(strdir) > 0
        setline(2, [""] + strdir)
    endif
enddef


def ReadDir(name: string): list<dict<any>>
    var path = resolve(name)
    var dirs = readdirex(path, (v) => v.type =~ 'dir\|junction\|linkd')
    var files = readdirex(path, (v) => v.type =~ 'file\|link$')
    return dirs + files
enddef


export def Open(name: string = '', focus: string = '')
    var oname = ""
    if &ft == "dir" && exists("b:dir") && exists("b:dir_cwd")
        oname = name
    else
        if !empty(bufname()) || &modified
            new
        endif
        set ft=dir
        set buftype=nofile
        set bufhidden=unload
        set noswapfile
        oname = expand(name) ?? expand("%:p:h")
    endif

    if isdirectory(oname)
        b:dir = ReadDir(oname)
        b:dir_cwd = oname->substitute('\', '/', 'g')
        exe $"lcd {oname}"
        PrintDir(b:dir)
        norm! j
        if empty(focus)
            if len(b:dir) > 0
                search(escape(b:dir[0].name, '~$.'))
            endif
        else
            search(escape(focus, '~$.'))
        endif
        # XXX: provide new name if taken already!
        exe $"file dir://{oname}"
    else
        echo "Not a directory."
    endif
enddef
