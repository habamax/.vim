setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

if exists("g:loaded_ale")
    setl omnifunc=ale#completion#OmniFunc
endif
