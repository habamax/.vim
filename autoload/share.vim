" Name: autoload/share.vim
" Author: Maxim Kim <habamax@gmail.com>
" Desc: Share text using pastebin like services.
" Example command:
" command! -range=% -nargs=? -complete=customlist,share#complete_service Share call share#paste(<q-args>, <line1>, <line2>)


let s:paste_service = {
            \ 'vpaste': [{-> 'http://vpaste.net/?ft=' .. &ft}, 'text=<-'],
            \ 'dpaste': [{-> 'http://dpaste.com/api/v2/'}, 'content=<-'],
            \ 'ix'    : [{-> 'http://ix.io/'}, 'f:1=<-'],
            \ 'clbin' : [{-> 'https://clbin.com/'}, 'clbin=<-']
            \}


" Paste lines from current buffer to one of the s:paste_service
" Save URL in clipboard.
func! share#paste(service, line1, line2) abort
    let service = s:paste_service->get(a:service, s:paste_service.vpaste)
    let [l:Paste_url, paste_param] = service
    let url = s:paste_curl(l:Paste_url(), paste_param, a:line1, a:line2)
    let @+ = url
    let @@ = url
    echom "Shared as " .. url
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


" Helper command completion function
func! share#complete_service(A, L, P) abort
    let result = s:paste_service->keys()
    if empty(a:A)
        return result
    else
        return result->matchfuzzy(a:A)
    endif
endfunc
