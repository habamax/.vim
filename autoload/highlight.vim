"" print all highlight groups starting with 'hi_name'
func! highlight#show(hi_name) abort
    for hl in getcompletion(a:hi_name, 'highlight')
        exe printf("hi %s", hl)
    endfor
endfunc
