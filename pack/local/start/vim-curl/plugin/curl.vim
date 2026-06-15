vim9script
if exists("g:loaded_curl")
    finish
endif
g:loaded_curl = 1

import autoload 'curl.vim'

command! -range -bang Curl curl.Execute(<line1>, <line2>, empty("<bang>") ? false : true)
