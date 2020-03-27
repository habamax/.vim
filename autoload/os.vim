"" Open explorer/finder/fm where current file is located
func! os#show_file() abort
    " Windows only for now
    if !has("win32")
        return
    endif

    if exists("b:netrw_curdir")
        let subcmd = '"' . substitute(b:netrw_curdir, "/", "\\", "g") . '"'
    elseif exists("b:dirvish")
        let subcmd = '/select,"' . getline('.') . '"'
    elseif expand("%:p") == ""
        let subcmd = '"' . expand("%:p:h") . '"'
    else
        let subcmd = '/select,"' . expand("%:p") . '"'
    endif
    exe "silent !start explorer " . subcmd
endfunc


"" Open URL under cursor using OS
"" http://ya.ru
"" ~/docs
"" $HOME/docs
"" C:/Users/maksim.kim/docs
"" .
func! os#open_url(word) abort
    " Windows only for now
    if !has("win32")
        return
    endif
    let word = a:word
    if word =~ '^[~.$].*'
        let word = expand(word)
    endif
    " TODO: check if barebone url
    " TODO: check if path or a filename
    " TODO: check and extract asciidoctor url
    " TODO: check and extract markdown url
    exe printf("silent !start %s", word)
endfunc


