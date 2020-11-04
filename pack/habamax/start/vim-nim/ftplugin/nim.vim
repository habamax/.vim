if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl cms< com< fo<"
else
    let b:undo_ftplugin = "setl cms< com< fo<"
endif


setlocal formatoptions-=t formatoptions+=croql
setlocal comments=:##,:#
setlocal commentstring=#\ %s
setlocal suffixesadd=.nim
setlocal expandtab
