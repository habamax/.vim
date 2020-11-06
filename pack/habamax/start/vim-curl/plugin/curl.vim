if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

command! -range Curl <line1>,<line2>call curl#do()
