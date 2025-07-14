vim9script

if exists("b:did_after_ftplugin")
    finish
endif
b:did_after_ftplugin = 1

if exists('b:undo_ftplugin')
    b:undo_ftplugin ..= "|setl list<"
endif

setl nolist
