" Personal jounaling using vim and asciidoctor
" Example mapping: nnoremap <silent> <leader>ej :call journal#new()<CR>
"
" * Opens ~/docs/journal/YEAR.adoc file, where YEAR is a current year, like 2020
"
" * Position cursor on current date heading
"     == 2020-08-14 Heading
"
" * If there is no current date heading, create it
"     == 2020-08-14
"
"     CURSOR IS HERE


func! journal#new() abort
    let jfilename = strftime("%Y") . '.adoc'
    let home = empty($DOCSHOME)?expand('~'):expand($DOCSHOME)
    let jfullname = printf('%s/docs/journal/%s', home, jfilename)

    call s:new_entry(jfullname)
endfunc


func! s:new_entry(jfilename) abort
    if bufexists(a:jfilename)
        exe "b " . a:jfilename
    else
        exe "e " . a:jfilename
    endif

    normal gg

    let journal_heading = '= ' . strftime("%Y")
    if getline(1) !~ '^' . journal_heading
        call append(0, [journal_heading, ""])
    endif

    let heading_date = '== ' . strftime("%Y-%m-%d")
    if search('^'.heading_date, 'cw')
        normal 2j
        return
    endif

    if search('^==\s*\S\+', 'cw')
        call append(line('.')-1, heading_date)
        normal 4O
        normal 2k
    else
        call append(line('$'), heading_date)
        normal G
        normal 2o
    endif
endfunc
