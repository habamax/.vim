vim9script

def SetTemplateFiletype()
    var ft = expand("%:p:h:t")
    if ft != "templates"
        &ft = ft
    endif
enddef

autocmd BufNewFile,BufRead *templates/* call SetTemplateFiletype()

