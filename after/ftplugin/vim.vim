setlocal shiftwidth=2
setlocal keywordprg=:help
setlocal fdm=marker
if !&readonly
  setlocal ff=unix
endif

noremap <buffer> <F5> :up<CR>:so %<CR>

augroup vim "{{{
  au!
  " Before _vimrc is saved, update 'Last Change' time if it is exists.
  if exists("*LastChangeUpdate")
    au BufWritePre <buffer> call LastChangeUpdate()
  endif
augroup end "}}}

iab <buffer> fu1 fu!
