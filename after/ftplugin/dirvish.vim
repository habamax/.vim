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
            let newfname = fpath . '/' . join([fname . counter, fext], '.')
            if !filereadable(newfname)
                break
            endif
            let counter += 1
        endw

        " TODO: add linux support
        call system(printf("copy %s %s", shellescape(ffullname), shellescape(newfname)))
    endif
endfunc

func! s:rename_file() abort
    let [ffullname, fext, fname, fpath] = s:filename()

    if !isdirectory(ffullname) && filereadable(ffullname)
        let name = input("New file name: ", fname)
        if name =~ '^\s*$' || name == fname
            return
        endif

        let newfname = fpath . '/' . join([name, fext], '.')

        if filereadable(newfname)
            echom "Can't rename, file exists!"
            return
        endif

        " TODO: add linux support
        call system(printf("move %s %s", shellescape(ffullname), shellescape(newfname)))
    endif
endfunc

command! -buffer DirvishDupFile call s:dup_file() | normal R
command! -buffer DirvishRenameFile call s:rename_file() | normal R
nnoremap <buffer> <leader><leader>d :DirvishDupFile<CR>
nnoremap <buffer> <leader><leader>r :DirvishRenameFile<CR>
