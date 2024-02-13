vim9script

if exists("b:did_ftplugin")
    finish
endif
b:did_ftplugin = 1

if exists('b:undo_ftplugin')
    b:undo_ftplugin ..= "|setl cms<"
else
    b:undo_ftplugin = "setl cms<"
endif

setlocal commentstring=#\ %s
