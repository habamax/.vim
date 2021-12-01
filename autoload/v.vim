" Helper notification function
func! v#popup(...) abort
    call popup_notification(call("printf", a:000), {})
endfunc

func! s:logger(kind, ...) abort
    let logfile = expand("~/.vimdata/vim".strftime("%Y%m%d").".log")
    let logline = printf("%s - %s - %s: %s", strftime("%H:%M:%S"), expand("%:p"), a:kind, call("printf", a:000))
    call writefile([logline], logfile, "a")
endfunc

func! v#log(...) abort
    call call("s:logger", ["DEBUG"] + a:000)
endfunc

func! v#logi(...) abort
    call call("s:logger", ["INFO"] + a:000)
endfunc

func! v#loge(...) abort
    call call("s:logger", ["ERROR"] + a:000)
endfunc

func! v#logw(...) abort
    call call("s:logger", ["WARNING"] + a:000)
endfunc
