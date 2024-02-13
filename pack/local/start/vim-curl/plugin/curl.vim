vim9script
if exists("g:loaded_curl")
    finish
endif
g:loaded_curl = 1

import autoload 'curl.vim'

command! -range Curl curl.Execute(<line1>, <line2>)
