if exists("g:loaded_curl")
    finish
endif
let g:loaded_curl = 1

command! -range Curl <line1>,<line2>call curl#do()
