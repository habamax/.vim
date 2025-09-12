vim9script

import autoload 'popup.vim'
def ShowQFItem()
    if empty(getqflist())
        echo "Quickfix list is empty"
        return
    endif
    popup.ShowAtCursor(getqflist()[line('.') - 1].text)
enddef
nnoremap <buffer> i <scriptcmd>ShowQFItem()<CR>

def KillJobs()
    for job in [get(g:, "make_jobid", null_job)]
        if job_status(job) == "run"
            ch_close(job->job_getchannel())
            job_stop(job, "kill")
            echom $"Killing job `{job_info(job).cmd->join()}`, process `{job_info(job).process}` ... {job_info(job).status}"
        endif
    endfor
enddef
nnoremap <buffer> <C-c> <scriptcmd>KillJobs()<CR>
