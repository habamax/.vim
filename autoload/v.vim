" Helper notification function
func! v#popup(...) abort
    call popup_notification(call("printf", a:000), {})
endfunc
