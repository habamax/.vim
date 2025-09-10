vim9script

import autoload 'popup.vim'
nnoremap <buffer> i <scriptcmd>popup.ShowAtCursor(getqflist()[line('.') - 1].text)<CR>

def KillJobs()
    if exists("b:grep_jobid") && job_status(b:grep_jobid) == "run"
        job_stop(b:grep_jobid)
    endif
    if exists("b:make_jobid") && job_status(b:make_jobid) == "run"
        job_stop(b:make_jobid)
    endif
    if exists("b:qf_jobid") && job_status(b:qf_jobid) == "run"
        job_stop(b:qf_jobid)
    endif
enddef
nnoremap <buffer> <C-c> <scriptcmd>KillJobs()<CR>
