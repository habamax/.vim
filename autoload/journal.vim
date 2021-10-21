" Personal jounaling using vim and reStructuredText
" Example mapping: nnoremap <silent> <leader>ej :call journal#new()<CR>
"
" * Opens ~/docs/journal/YEAR.txt file, where YEAR is a current year, like 2020
"
" * Position cursor 2 lines after current date heading
"     2020-08-14 Heading
"     ==================
"
"     CURSOR IS HERE
"
" * If there is no current date heading, create it and position cursor 2 lines after
"     2020-08-14
"     ==========
"
"     CURSOR IS HERE


func! journal#new() abort
    let jfilename = strftime("%Y") . '.txt'
    let jfullname = simplify(printf('%s/journal/%s', expand($DOCS ?? '~/docs'), jfilename))
    call s:new_entry(jfullname)
endfunc


func! s:new_entry(jfilename) abort
    if bufexists(a:jfilename)
        exe "b " . a:jfilename
    else
        exe "e " . a:jfilename
    endif

    normal! gg

    let journal_heading = [repeat('=', 78), strftime("%Y"), repeat('=', 78), '']
    if join(getline(1, 3), "\n") !~ '^=\{78}\n\s*\d\d\d\d\s*\n=\{78}'
        call append(0, journal_heading)
        2center
    endif

    let heading_date = [strftime("%Y-%m-%d"), repeat('=', 10)]
    if search('^'.heading_date[0].'\n'.repeat('=', 10), 'cw')
        normal! 3j
        return
    endif

    if search('^\d\d\d\d-\d\d-\d\d\s*.*\n=\{10,}', 'cw')
        call append(line('.')-1, heading_date)
        normal! 4O
        normal! 2k
    else
        call append(line('$'), heading_date)
        normal! G
        normal! 2o
    endif
endfunc
