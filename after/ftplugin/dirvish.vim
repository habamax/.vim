func! s:filename() abort
    let ffullname = fnamemodify(getline('.'), ":p")
    let fext = fnamemodify(getline('.'), ":e")
    let fname = fnamemodify(getline('.'), ":t:r")
    let fpath = fnamemodify(getline('.'), ":p:h")
    return [ffullname, fext, fname, fpath]
endfunc

func! s:dup_file() abort
    let [ffullname, fext, fname, fpath] = s:filename()
    if !isdirectory(ffullname) && filereadable(ffullname)
        let counter = 2
        while 1
            let newfname = fpath . '/' . fname . counter . (fext == '' ? '' : '.' . fext)
            if !filereadable(newfname)
                break
            endif
            let counter += 1
        endw

        if has("win32")
            let cmd = "copy"
        else
            let cmd = "cp"
        endif

        call system(printf("%s %s %s", cmd, shellescape(ffullname), shellescape(newfname)))
    endif
endfunc

func! s:rename_file() abort
    let [ffullname, fext, fname, fpath] = s:filename()

    if !isdirectory(ffullname) && filereadable(ffullname)
        let name = input("New file name: ", fname)
        if name =~ '^\s*$' || name == fname
            return
        endif

        let newfname = fpath . '/' . name . (fext == '' ? '' : '.' . fext)

        if filereadable(newfname)
            echom "Can't rename, file exists!"
            return
        endif

        if has("win32")
            let cmd = "move"
        else
            let cmd = "mv"
        endif

        call system(printf("%s %s %s", cmd, shellescape(ffullname), shellescape(newfname)))
    endif
endfunc

command! -buffer DirvishDupFile call s:dup_file() | normal R
command! -buffer DirvishRenameFile call s:rename_file() | normal R
nnoremap <buffer> <leader><leader>d :DirvishDupFile<CR>
nnoremap <buffer> <leader><leader>r :DirvishRenameFile<CR>
