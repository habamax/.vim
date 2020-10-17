if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl autoread<"
else
    let b:undo_ftplugin = "setl autoread<"
endif

setlocal autoread
