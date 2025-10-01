vim9script

var popup_borderchars = get(g:, "popup_borderchars", ['─', '│', '─', '│', '┌', '┐', '┘', '└'])
var popup_borderhighlight = get(g:, "popup_borderhighlight", ['Normal'])
var popup_highlight = get(g:, "popup_highlight", 'Normal')
const UPD1 = "○"
const UPD2 = "●"
const INST1 = "⬠"
const INST2 = "⬟"

const MAX_JOBS = 10
var pack_jobs = []
var pack_msg = {}

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

def ShowChangelog()
    var lines = []
    for [name, msg] in pack_msg->items()
        if !empty(msg)
            lines->add(name)
            lines->add(repeat("=", strlen(name)))
            lines += [''] + msg->split("\n") + ['', '']
        endif
    endfor
    if empty(lines)
        popup_notification("All plugins are up to date.", {
            title: " Plugins ",
            borderchars: popup_borderchars,
            line: &lines - 4,
            col: &columns - 20
        })
        return
    endif
    new
    setl nobuflisted noswapfile buftype=nofile
    nnoremap <buffer> gq <cmd>bd!<CR>
    set syntax=git
    syn match H1 "^.\+\n=\+$"
    hi! link H1 Title
    setline(1, lines[ : -3])
enddef

def CreatePopup(Setup: func(number) = null_function): tuple<number, number>
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
    })

    if Setup != null_function
        Setup(winid)
    endif

    return (winid, getwininfo(winid)[0].bufnr)
enddef

# Update or install plugins listed in packs
export def Update()
    if IsRunning()
        echow "Previous update is not finished yet!"
        return
    endif

    pack_jobs = []
    pack_msg = {}
    var packages = Packages()
    if empty(packages)
        echow "No packages to install or update!"
        return
    endif

    var [winid, bufnr] = CreatePopup((id) => {
        win_execute(id, $"syn match PackUpdateDone '^{UPD2}'")
        win_execute(id, $"syn match PackInstallDone '^{INST2}'")
        hi def link PackUpdateDone Added
        hi def link PackInstallDone Changed
    })

    timer_start(1000, (t) => {
        if !IsRunning()
            timer_stop(t)
            popup_close(winid)
            helptags ALL
            ShowChangelog()
        endif
    }, {repeat: -1})

    timer_start(100, (t) => {
        if empty(packages)
            timer_stop(t)
            return
        endif
        pack_jobs->filter((_, v) => job_status(v) == 'run')
        if pack_jobs->len() >= MAX_JOBS
            return
        endif
        var [name, url] = packages->remove(0)
        var path = $"{$MYVIMDIR}/pack/{name}"
        if isdirectory(path)
            if empty(getbufoneline(bufnr, 1))
                setbufline(bufnr, 1, $"{UPD1} {name}")
            else
                appendbufline(bufnr, '$', $"{UPD1} {name}")
            endif
            var info = {}
            pack_msg[name] = ""
            var job = job_start([&shell, &shellcmdflag, 'git fetch -q && git log HEAD..@{u} && git reset --hard -q @{u} && git clean -dfx -q'], {
                cwd: path,
                out_cb: (ch, msg) => {
                    pack_msg[name] ..= $"{msg}\n"
                },
                close_cb: (_) => {
                    var buftext = getbufline(bufnr, 1, '$')
                    buftext = buftext->mapnew((_, v) => {
                        if v == $"{UPD1} {name}"
                            return $"{UPD2} {name}"
                        else
                            return v
                        endif
                    })
                    popup_settext(winid, buftext)
                }}
            )
            pack_jobs->add(job)
        else
            if empty(getbufoneline(bufnr, 1))
                setbufline(bufnr, 1, $"{INST1} {name}")
            else
                appendbufline(bufnr, '$', $"{INST1} {name}")
            endif
            var job = job_start($'git clone {url} {path}', {
                cwd: $MYVIMDIR,
                close_cb: (_) => {
                    var buftext = getbufline(bufnr, 1, '$')
                    buftext = buftext->mapnew((_, v) => {
                        if v == $"{INST1} {name}"
                            return $"{INST2} {name}"
                        else
                            return v
                        endif
                    })
                    pack_msg[name] = "Installed.\n"
                    popup_settext(winid, buftext)
                }}
            )
            pack_jobs->add(job)
        endif
    }, {"repeat": -1})
enddef
