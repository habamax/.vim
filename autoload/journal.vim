vim9script

# Personal jounaling using vim and reStructuredText
# Example mapping: nnoremap <silent> <leader>ej :call journal#new()<CR>
#
# * Opens ~/docs/journal/YEAR.txt file, where YEAR is a current year, like 2020
#
# * Position cursor 2 lines after current date heading
#     2020-08-14 Heading
#     ==================
#
#     CURSOR IS HERE
#
# * If there is no current date heading, create it and position cursor 2 lines after
#     2020-08-14
#     ==========
#
#     CURSOR IS HERE


export def New()
    var jfilename = strftime("%Y") .. '.txt'
    var jfullname = simplify(printf('%s/journal/%s', expand($DOCS ?? '~/docs'), jfilename))
    NewEntry(jfullname)
enddef


def NewEntry(jfilename: string)
    if bufexists(jfilename)
        exe "b " .. jfilename
    else
        exe "e " .. jfilename
    endif

    # search first 10 lines for a journal title
    var journal_heading = [repeat('#', 80), strftime("%Y"), repeat('#', 80), '']
    if join(getline(1, 10), "\n") !~ '\(^\|\n\)#\{80}\n\s*.\{-}\d\d\d\d\s*.*\n#\{80}'
        append(0, journal_heading)
        :2center
    endif

    :1

    var heading_date = [strftime("%Y-%m-%d"), repeat('=', 10)]
    if search('^' .. heading_date[0] .. '\n' .. repeat('=', 10), 'cw') != 0
        normal! 3j
        return
    endif

    if search('^\d\d\d\d-\d\d-\d\d\s*.*\n=\{10,}', 'cw') != 0
        append(line('.') - 1, heading_date)
        normal! 4O
        normal! 2k
    else
        append(line('$'), heading_date)
        normal! G
        normal! 2o
    endif
enddef
