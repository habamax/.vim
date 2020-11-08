if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1


if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl cms< fo<"
else
    let b:undo_ftplugin = "setl cms< fo<"
endif


setlocal formatoptions-=t formatoptions+=croql
setlocal commentstring=#\ %s
