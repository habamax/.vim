vim9script


var shell_job: job


def PrepareBuffer(): number
    var bufnr = bufadd('[Command Output]')
    bufload(bufnr)
    var windows = win_findbuf(bufnr)

    if windows->len() == 0
        exe "sb" bufnr
        set bufhidden=hide
        set buftype=nofile
        set buflisted
        set filetype=run
    else
        win_gotoid(windows[0])
    endif

    silent :%d _

    return bufnr
enddef


export def CaptureOutput(command: string)
    var bufnr = PrepareBuffer()

    setbufline(bufnr, 1, $"$ {command}")
    setbufline(bufnr, 2, "")

    if shell_job->job_status() == "run"
        shell_job->job_stop()
    endif

    shell_job = job_start(command, {
        out_io: 'buffer',
        out_buf: bufnr,
        out_msg: 0,
        err_io: 'buffer',
        err_buf: bufnr,
        err_msg: 0
    })
    normal! G
enddef


export def OpenFile(split: bool = false)
    # get python line nr
    var linenr = matchstr(getline('.'), '\s\+File "\f\+", line \zs\d\+\ze,')

    if split
        exe "normal! \<c-w>F"
    else
        normal! gF
    endif

    if !empty(linenr)
        exe $":{linenr}"
    endif
enddef
