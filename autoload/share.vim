"" Share text using pastebin like services.
"" Example commands:
"" command! -range=% PasteVP call share#vpaste(<line1>, <line2>)
"" command! -range=% PasteIX call share#ix(<line1>, <line2>)
"" command! -range=% PasteCL call share#clbin(<line1>, <line2>)


"" Paste lines from current buffer to vpaste.net
"" Save URL in clipboard.
func! share#vpaste(line1, line2) abort
    let @* = s:paste_curl('http://vpaste.net/', 'text=<-', a:line1, a:line2)
    echom "Pasted as " .. @*
endfunc

"" Paste lines from current buffer to ix.io
"" Save URL in clipboard.
func! share#ix(line1, line2) abort
    let @* = s:paste_curl('http://ix.io/', 'f:1=<-', a:line1, a:line2)
    echom "Pasted as " .. @*
endfunc

"" Paste lines from current buffer to clbin.com
"" Save URL in clipboard.
func! share#clbin(line1, line2) abort
    let @* = s:paste_curl('https://clbin.com/', 'clbin=<-', a:line1, a:line2)
    echom "Pasted as " .. @*
endfunc

"" Helper function to use curl for pastebin like websites
func! s:paste_curl(url, param, line1, line2) abort
    if !executable('curl')
        echom "curl is not available!"
        return
    endif
    let result = system(printf('curl -s -F "%s" "%s"', a:param, a:url),
                \ join(getline(a:line1, a:line2), "\n"))
    return substitute(result, "\n$", "", "")
endfunc

