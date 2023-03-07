vim9script


var shell_job: job


def PrepareBuffer(shell_cwd: string): number
    var bufname = "[Command output]"
    var buffers = getbufinfo()->filter((_, v) => fnamemodify(v.name, ":t") == bufname)

    var bufnr = -1

    if len(buffers) > 0
        bufnr = buffers[0].bufnr
    else
        bufnr = bufadd(bufname)
    endif

    var windows = win_findbuf(bufnr)

    if windows->len() == 0
        # g:shellcmd_main_win_mode is one of "", "vertical", "topleft", "botright", "botright vertical" etc
        exe get(g:, "shellcmd_main_win_mode", "botright vertical") "sbuffer" bufnr
        set bufhidden=hide
        set buftype=nofile
        set buflisted
        set filetype=shellcmd
        set noswapfile
        set noundofile
    else
        win_gotoid(windows[0])
    endif

    silent :%d _

    b:shell_cwd = shell_cwd

    return bufnr
enddef


export def CaptureOutput(command: string)
    var cwd = getcwd()
    var bufnr = PrepareBuffer(cwd)

    setbufline(bufnr, 1, $"$ {command}")
    setbufline(bufnr, 2, "")

    if shell_job->job_status() == "run"
        shell_job->job_stop()
    endif

    shell_job = job_start(command, {
        cwd: cwd,
        out_io: 'buffer',
        out_buf: bufnr,
        out_msg: 0,
        err_io: 'buffer',
        err_buf: bufnr,
        err_msg: 0
    })

    normal! G
enddef


export def OpenFile(mod: string = "")
    exe "lcd" b:shell_cwd
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
            endif

            if !empty(fname[3])
                exe $"normal! {fname[3]}|"
            endif
        catch
        endtry
    endif
enddef
