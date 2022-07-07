vim9script

# {'group': '', 'perm': 'rwxrwxrwx', 'name': '.bundle', 'user': '', 'type': 'dir', 'time': 1655218125, 'size': 0}
def PrintDir(dir: list<dict<any>>)
    setline(1, printf("%-10s %-8s %-8s %-8s %s", "permission", "owner", "group", "size", "name"))
    var strdir = dir->mapnew((_, v) => printf("%-9s %-8s %-8s %-8s %s",
            (v.type == 'file' ? '-' : v.type[0]) .. v.perm, v.user, v.group, v.size, v.name))
    setline(2, strdir)
enddef

export def Open(name: string = '')
    var dir_name = isdirectory(expand(name)) ? expand(name) : expand("%:p:h")
    if &ft != "dirvim"
        new
        set ft=dirvim
    endif
    :%d _
    b:dir = readdirex(dir_name)
    PrintDir(b:dir)
enddef
