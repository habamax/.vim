vim9script


var shell_job: job


def PrepareBuffer(): number
    var bufnr = bufadd('◆ Command Output ◆')
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
enddef
