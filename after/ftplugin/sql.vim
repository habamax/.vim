" npm i -g sql-formatter
if executable('sql-formatter')
    setlocal formatprg=sql-formatter
    command -buffer Fmt :%!sql-formatter
endif

iab ssf select * from
