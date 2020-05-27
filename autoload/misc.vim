"" Return unicode number up to 20 or just a number if > 20
""
"" Second function argument is boolean (default is v:true)
"" Whether to return negative or non-negative number chars
"" 
"" Used in statusline.vim and tabline.vim
func! misc#unicode_number(num, ...) abort
    let num = a:num
    if get(a:, 1, v:true)
        if a:num > 0 && a:num <= 10
            let num = nr2char(char2nr('❶') + (a:num - 1)) . ' '
        elseif a:num <= 20
            let num = nr2char(char2nr('⓫') + (a:num - 11)) . ' '
        endif
    else
        if a:num > 0 && a:num <= 20
            let num = nr2char(char2nr('①') + (a:num - 1)) . ' '
        endif
    endif
    return num
endfunc


"" Format JSON response VRC plugin provides
func! misc#vrc_format_rest_as_json() abort
    if bufname() != '__REST_response__'
        echom "Should only format __REST_response buffers!"
        return
    endif
    setlocal ma
    if getline(1) =~ '^HTTP'
        normal ggdap
    endif
    set ft=json
    " This command is defined in after/ftplugin/json.vim
    Format
endfunc


"" Paste lines from current buffer to vpaste.net
"" Save URL in clipboard.
func! misc#vpaste(line1, line2) abort
    if !executable('curl')
        echom "curl is not available!"
        return
    endif
    let result = system('curl -s -F "text=<-" "http://vpaste.net/"',
                \ join(getline(a:line1, a:line2), "\n")) 
    let @* = substitute(result, "\n$", "", "")
    echom "Pasted as " .. @*
endfunc
