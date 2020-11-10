setl textwidth=80
setl keywordprg=:help
if !&readonly
    setlocal ff=unix
endif

let b:foldtext_strip_comments = v:true

" make line continuation `\` less indented (default is *3)
" let g:vim_indent_cont = shiftwidth() * 2


inorea <buffer> augr augroup  \| au!<CR>
            \au BufRead * echo "hello world"<CR>
            \augroup END<Up><Up><Left><Left><Left>
            \<C-R>=Eatchar('\s')<CR>



if exists("g:loaded_select")
    func! s:get_bufdefs(buf) abort
        let result = getbufline(a:buf.bufnr, 1, '$')
                    \ ->map({i, ln -> printf("%*d: %s", len(line('$', a:buf.winid)), i+1, trim(ln))})
                    \ ->filter({_, val ->
                    \     val =~ '\<fu\%[nction]\>!\?\s*\k\+'
                    \     || val =~ '\<au\%[tocommand]\>!\?\s*\k\+'
                    \     || val =~ '\<com\%[mand]\>!\?\s*\k\+'
                    \ })

        return result
    endfunc
    let b:select_info = {}
    let b:select_info.bufdef = {}
    let b:select_info.bufdef.data = {_, v -> s:get_bufdefs(v)}
    let b:select_info.bufdef.sink = {
                \ "transform": {_, v -> matchstr(v, '^\s*\zs\d\+')},
                \ "action": "normal! %sG"
                \ }
    let b:select_info.bufdef.highlight = {"PrependLineNr": ['^\(\s*\d\+:\)', 'LineNr']}
    nnoremap <buffer><silent> <space>gd :Select bufdef<CR>
endif
