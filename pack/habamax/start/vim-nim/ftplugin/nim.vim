if exists('b:loaded_nim')
  finish
endif

let b:loaded_nim = 1

let s:cpo_save = &cpo
set cpo&vim


" TODO: set proper undos

setlocal formatoptions-=t formatoptions+=croql
setlocal comments=:##,:#
setlocal commentstring=#\ %s
setlocal suffixesadd=.nim 
setlocal expandtab


let &cpo = s:cpo_save
unlet s:cpo_save
