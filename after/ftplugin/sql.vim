" npm i -g sql-formatter
if executable('sql-formatter')
    setlocal formatprg=sql-formatter\ -i\ 4\ --lines-between-queries\ 3
    command -buffer Fmt :%!sql-formatter -i 4 --lines-between-queries 3
endif

let &l:commentstring = "-- %s"
