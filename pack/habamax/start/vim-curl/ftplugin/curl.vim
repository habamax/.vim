if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl cms<"
else
    let b:undo_ftplugin = "setl cms<"
endif

setlocal commentstring=#\ %s
