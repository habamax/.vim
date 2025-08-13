vim9script

import autoload 'popup.vim'

var popup_borderchars = get(g:, "popup_borderchars", ['─', '│', '─', '│', '┌', '┐', '┘', '└'])
var popup_borderhighlight = get(g:, "popup_borderhighlight", ['Normal'])
var popup_highlight = get(g:, "popup_highlight", 'Normal')

const MAX_JOBS = 10
var pack_jobs = []

def Packages(): list<tuple<string, string>>
    var pack_list = $'{$MYVIMDIR}pack/packs'
    if !filereadable(pack_list)
        return []
    endif
    var plugs = readfile(pack_list)
    var packages = []
    for pinfo in plugs
        if pinfo =~ '^\s*#' || pinfo =~ '^\s*$'
            continue
        endif
        var [name, url] = pinfo->split("\t")
        if empty(name) || empty(url)
            continue
        endif
        packages->add((name, url))
    endfor
    return packages
enddef

def IsRunning(): bool
    return reduce(pack_jobs, (acc, val) => acc || job_status(val) == 'run', false)
enddef

def InstallPack(path: string, url: string)
    var job = job_start($'git clone {url} {path}',
        {"err_cb": OutCb, "out_cb": OutCb})
    pack_jobs->add(job)
enddef

def CreatePopup(): tuple<number, number>
    var grab_bufnr = 0

    var winid = popup_create("", {
        title: $" Plugins ",
        pos: 'botright',
        col: &columns,
        line: &lines,
        padding: [0, 1, 0, 1],
        border: [1, 1, 1, 1],
        mapping: 1,
        tabpage: -1,
        borderchars: popup_borderchars,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        filter: (winid, key) => {
            if key == "\<C-g>"
                var lines = getbufline(getwininfo(winid)[0].bufnr, 1, '$')
                if grab_bufnr == 0
                    grab_bufnr = bufadd("")
                    exe $"sbuffer {grab_bufnr}"
                    setl nobuflisted noswapfile buftype=nofile
                elseif bufwinnr(grab_bufnr) == -1
                    exe $"sbuffer {grab_bufnr}"
                endif
                setbufline(grab_bufnr, 1, lines)
                return true
            endif
            return false
        },
    })
    return (winid, getwininfo(winid)[0].bufnr)
enddef

# Update or install plugins listed in packs
export def Update()
    if IsRunning()
        echow "Previous update is not finished yet!"
        return
    endif

    var [winid, bufnr] = CreatePopup()
    var packages = Packages()

    timer_start(1000, (t) => {
        if !IsRunning()
            timer_start(2000, (_) => {
                timer_stop(t)
                popup_close(winid)
            })
        endif
    }, {repeat: -1})

    timer_start(100, (t) => {
        if empty(packages)
            timer_stop(t)
            helptags ALL
            return
        endif
        pack_jobs->filter((_, v) => job_status(v) == 'run')
        if pack_jobs->len() >= MAX_JOBS
            return
        endif
        var [name, url] = packages->remove(0)
        var path = $"{$MYVIMDIR}/pack/{name}"
        appendbufline(bufnr, '$', $"○ {name}")
        if isdirectory(path)
            var job = job_start([&shell, &shellcmdflag, 'git fetch && git reset --hard @{u} && git clean -dfx'], {
                "cwd": path,
                close_cb: (ch) => {
                    var buftext = getbufline(bufnr, 1, '$')
                    buftext = buftext->mapnew((_, v) => {
                        if v == $"○ {name}"
                            return $"● {name}"
                        else
                            return v
                        endif
                    })
                    popup_settext(winid, buftext)
                }}
            )
            pack_jobs->add(job)
        else
            var job = job_start($'git clone {url} {path}', {
                "cwd": path,
                close_cb: (ch) => {
                    var buftext = getbufline(bufnr, 1, '$')
                    buftext = buftext->mapnew((_, v) => {
                        if v == $"○ {name} ..."
                            return $"● {name}"
                        else
                            return v
                        endif
                    })
                    popup_settext(winid, buftext)
                }}
            )
            pack_jobs->add(job)
        endif
    }, {"repeat": -1})
enddef
