vim9script


def PermStr(e: dict<any>): string
    return (e.type == 'file' ? '-' : e.type[0]) .. e.perm
enddef


def PrintDir(dir: list<dict<any>>)
    :%d _
    setline(1, b:dir_cwd)
    setline(2, "")
    var strdir = []
    if has("win32")
        setline(3, printf("%-10s %-8s %s", "permission", "size", "name"))
        strdir = dir->mapnew((_, v) =>
                printf("%-9s %-8s %s", PermStr(v), v.size, v.name))
    else
        setline(3, printf("%-10s %-8s %-8s %-8s %s", "permission", "owner", "group", "size", "name"))
        strdir = dir->mapnew((_, v) =>
                printf("%-9s %-8s %-8s %-8s %s", PermStr(v), v.user, v.group, v.size, v.name))
    endif
    setline(4, strdir)
enddef


def ReadDir(name: string): list<dict<any>>
    return readdirex(resolve(name), (v) => v.type != 'file')
         + readdirex(resolve(name), (v) => v.type == 'file')
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
        PrintDir(b:dir)
        if empty(focus)
            search("name")
            norm! j
        else
            search(focus)
        endif
        exe $"lcd {oname}"
        # XXX: provide new name if taken already!
        exe $"file dir://{oname}"
    else
        echo "Not a directory."
    endif
enddef
