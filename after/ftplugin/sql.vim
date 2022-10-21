" npm i -g sql-formatter
if executable('sql-formatter')
    setlocal formatprg=sql-formatter
    command -buffer Fmt :%!sql-formatter
endif

let &l:commentstring = "-- %s"
