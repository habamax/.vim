vim9script

if exists("b:did_ftplugin")
    finish
endif

b:did_ftplugin = 1

b:undo_ftplugin = "setl comments< commentstring< formatprg<"

# setlocal omnifunc=
setlocal comments=:-- commentstring=--\ %s
iab <buffer> ssf select * from

# npm i -g sql-formatter
if executable('sql-formatter')
    setlocal formatprg=sql-formatter
    command -buffer Fmt :%!sql-formatter
endif

