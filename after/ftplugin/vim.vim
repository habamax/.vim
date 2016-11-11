setlocal keywordprg=:help
setlocal fdm=marker
if !&readonly
  setlocal ff=unix
endif

setl noexpandtab tabstop=4 shiftwidth=4
