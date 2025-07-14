if exists("b:did_after_ftplugin")
    finish
endif
let b:did_after_ftplugin = 1

" npm i -g sql-formatter
if executable('sql-formatter')
    setlocal formatprg=sql-formatter
    command -buffer Fmt :%!sql-formatter
endif

iab ssf select * from
