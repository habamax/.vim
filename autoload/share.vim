" Name: autoload/share.vim
" Author: Maxim Kim <habamax@gmail.com>
" Desc: Share text using pastebin like services.
" Example commands:
" command! -range=% PasteVP call share#paste('vpaste', <line1>, <line2>)
" command! -range=% PasteDP call share#paste('dpaste', <line1>, <line2>)
" command! -range=% PasteIX call share#paste('ix', <line1>, <line2>)
" command! -range=% PasteCL call share#paste('clbin', <line1>, <line2>)

let s:paste_service = {
            \ 'vpaste': [{-> 'http://vpaste.net/?ft=' .. &ft}, 'text=<-'],
            \ 'dpaste': [{-> 'http://dpaste.com/api/v2/'}, 'content=<-'],
            \ 'ix'    : [{-> 'http://ix.io/'}, 'f:1=<-'],
            \ 'clbin' : [{-> 'https://clbin.com/'}, 'clbin=<-']
            \}

" Paste lines from current buffer to one of the s:paste_service
" Save URL in clipboard.
func! share#paste(service, line1, line2) abort
    if empty(get(s:paste_service, a:service, ''))
        echom "Unknown paste service!"
        return
    endif

    let [l:Paste_url, paste_param] = s:paste_service[a:service]
    let url = s:paste_curl(l:Paste_url(), paste_param, a:line1, a:line2)
    let @+ = url
    let @@ = url
    echom "Pasted as " .. url
endfunc


" Helper function to use curl for pastebin like websites
func! s:paste_curl(url, param, line1, line2) abort
    if !executable('curl')
        echom "curl is not available!"
        return
    endif
    let result = system(printf('curl -s -F "%s" "%s"', a:param, a:url),
                \ join(getline(a:line1, a:line2), "\n"))
    return substitute(result, "\n$", "", "")
endfunc
