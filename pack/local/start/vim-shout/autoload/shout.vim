vim9script

# g:shout_main_win_mode is "botright vertical" and could be one of:
# "", "vertical", "topleft", "botright", "botright vertical" etc


var shout_job: job


def PrepareBuffer(shell_cwd: string): number
    var bufname = "[shout]"
    var buffers = getbufinfo()->filter((_, v) => fnamemodify(v.name, ":t") == bufname)

    var bufnr = -1

    if len(buffers) > 0
        bufnr = buffers[0].bufnr
    else
        bufnr = bufadd(bufname)
    endif

    var windows = win_findbuf(bufnr)

    if windows->len() == 0
        exe get(g:, "shout_main_win_mode", "botright vertical") "sbuffer" bufnr
        setl bufhidden=hide
        setl buftype=nofile
        setl buflisted
        setl filetype=shout
        setl noswapfile
        setl noundofile
    else
        win_gotoid(windows[0])
    endif

    silent :%d _

    b:shout_cwd = shell_cwd
    exe "silent lcd" shell_cwd

    setl undolevels=-1

    return bufnr
enddef


export def CaptureOutput(command: string, follow: bool = false)
    var cwd = getcwd()
    var bufnr = PrepareBuffer(cwd)

    setbufline(bufnr, 1, $"$ {command}")
    setbufline(bufnr, 2, "")

    if shout_job->job_status() == "run"
        shout_job->job_stop()
    endif

    var job_command: any
    if has("win32")
        job_command = command
    else
        job_command = [&shell, &shellcmdflag, escape(command, '\')]
    endif

    shout_job = job_start(job_command, {
        cwd: cwd,
        out_io: 'buffer',
        out_buf: bufnr,
        out_msg: 0,
        err_io: 'out',
        err_buf: bufnr,
        err_msg: 0,
        close_cb: (channel) => {
            if !bufexists(bufnr)
                return
            endif
            var msg = [""]
            msg += ["Exit code: " .. job_info(shout_job).exitval]
            var winid = bufwinid(bufnr)
            appendbufline(bufnr, line('$', winid), msg)
            if follow
                win_execute(winid, "normal! G")
            endif
            win_execute(winid, "setl undolevels&")
        }
    })

    if follow
        normal! G
    endif
enddef


export def OpenFile(mod: string = "")
    exe "silent lcd" b:shout_cwd


    # re-run the command if on line 1
    if line('.') == 1
        var cmd = getline(".")->matchstr('^\$ \zs.*$')
        if cmd !~ '^\s*$'
            var pos = getcurpos()
            CaptureOutput(cmd, false)
            setpos('.', pos)
        endif
        return
    endif


    # Windows has : in `isfname` thus for ./filename:20:10: gf can't find filename cause
    # it sees filename:20:10: instead of just filename
    # So the "hack" would be:
    # - take <cWORD> or a line under cursor
    # - extract file name, line, column
    # - edit file name

    # python
    var fname = getline('.')->matchlist('^\s\+File "\(.\{-}\)", line \(\d\+\)')

    # rust
    if empty(fname)
        fname = getline('.')->matchlist('^\s\+--> \(.\{-}\):\(\d\+\):\(\d\+\)')
    endif

    # regular filename:linenr:colnr:
    if empty(fname)
        fname = getline('.')->matchlist('^\(.\{-}\):\(\d\+\):\(\d\+\).*')
    endif

    # regular filename:linenr:
    if empty(fname)
        fname = getline('.')->matchlist('^\(.\{-}\):\(\d\+\):\?.*')
    endif

    # regular filename:
    if empty(fname)
        fname = getline('.')->matchlist('^\(.\{-}\):.*')
    endif

    if fname->len() > 0 && filereadable(fname[1])
        try
            # goto opened file if it is visible
            # split otherwise
            var buffers = getbufinfo()->filter((_, v) => v.name == fnamemodify(fname[1], ":p"))
            if len(buffers) > 0 && len(buffers[0].windows) > 0
                win_gotoid(buffers[0].windows[0])
            else
                exe mod "split" fname[1]
            endif

            if !empty(fname[2])
                exe $":{fname[2]}"
                exe "normal! 0"
            endif

            if !empty(fname[3]) && fname[3]->str2nr() > 1
                exe $"normal! {fname[3]->str2nr() - 1}l"
            endif
            normal! zz
        catch
        endtry
    endif
enddef


export def Kill()
    if shout_job != null
        job_stop(shout_job)
    endif
enddef


# TODO: think of a proper command completion
# shell commands
# files/directories with shell commands and |, >, && and ||
export def Complete(ArgLead: string, CmdLine: string, CursorPos: number): string
    if empty(ArgLead)
        return ''
    endif
    return getcompletion(ArgLead, 'shellcmd')->join("\n")
enddef
