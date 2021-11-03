" Name: autoload/share.vim
" Author: Maxim Kim <habamax@gmail.com>
" Desc: Share text using pastebin like services.
" Usage:
" Define command
" command! -range=% -nargs=? -complete=customlist,share#complete Share call share#paste(<q-args>, <line1>, <line2>)
"
" Share whole buffer with default 0x0.st
" :Share<CR>
"
" Share whole buffer with clbin.com
" :Share clbin<CR>
"
" Share selection with vpaste.net
" :'<,'>Share<CR>


let s:paste_service = {
            \ '0x0' : [{-> 'https://0x0.st/'}, 'file=@-'],
            \ 'envs' : [{-> 'https://envs.sh/'}, 'file=@-;'],
            \ 'clbin' : [{-> 'https://clbin.com/'}, 'clbin=<-'],
            \ 'dpaste': [{-> 'http://dpaste.com/api/v2/'}, 'content=<-'],
            \ 'ix' : [{-> 'http://ix.io/'}, 'f:1=<-'],
            \ 'vpaste': [{-> 'http://vpaste.net/?ft=' . &ft}, 'text=<-']
            \}


" Paste lines from current buffer to one of the s:paste_service
" Save URL in clipboard.
func! share#paste(service, line1, line2) abort
    let service = s:paste_service->get(a:service, s:paste_service["0x0"])
    let [l:Paste_url, paste_param] = service
    let url = s:paste_curl(l:Paste_url(), paste_param, a:line1, a:line2)
    let @+ = url
    let @@ = url
    echom "Shared as " . url
endfunc


" Helper function to use curl for pastebin like websites
func! s:paste_curl(url, param, line1, line2) abort
    if !executable('curl')
        echom "curl is not available!"
        return
    endif
    let result = system(printf('curl -s -F "%s" "%s"', a:param, a:url),
                \ join(getline(a:line1, a:line2), "\n"))
    return result->trim()
endfunc


" Helper command completion function
func! share#complete(A, L, P) abort
    let result = s:paste_service->keys()
    if empty(a:A)
        return result
    else
        return result->matchfuzzy(a:A)
    endif
endfunc
