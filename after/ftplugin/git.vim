vim9script

if exists('b:undo_ftplugin')
    b:undo_ftplugin ..= "|setl list<"
endif

setl nolist
