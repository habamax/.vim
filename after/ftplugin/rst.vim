if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl tw< sw< fo<"
else
    let b:undo_ftplugin = "setl tw< sw< fo<"
endif

compiler rst2html

" TODO: add it to undo ftplugin
command -buffer RSTViewHtml :call os#open(expand("%:p:r").'.html')
nnoremap <buffer> goh :RSTViewHtml<CR>

command -buffer -nargs=? -complete=locale RSTHtml call s:rst2html(<f-args>)

func! s:rst2html(...) abort
    if !empty(a:000)
        let b:rst2html_opts = g:rst2html_opts . " --language=" . a:1
    else
        let b:rst2html_opts = g:rst2html_opts
    endif
    compiler rst2html
    if exists(":Make")
        Make
    else
        make
    endif
endfunc

setlocal textwidth=79
setlocal formatoptions=tnc
setlocal shiftwidth=2

func! s:hl_checkmark() abort
    syn match rstCheckMark /✓\(\s*(\d\{4}-\d\d-\d\d)\)\?/ contains=rstCheckMarkDate
    syn match rstCheckMarkDate /(\d\{4}-\d\d-\d\d)/ contained
    hi link rstCheckMark Function
    hi link rstCheckMarkDate Special
endfunc

augroup checkmark | au!
    au Syntax rst call s:hl_checkmark()
    au Colorscheme * call s:hl_checkmark()
augroup END



command! -buffer -range RSTFixTable :call s:fixSimpleTable(<line1>, <line2>)

func! s:fixSimpleTable(line1, line2) abort
    let table = []
    if getline(a:line1) !~ '^\s*\%(===\+\)\%(\s\+===\+\)\+\s*$'
        return
    endif
    let col_width = split(getline(a:line1), '\s\+')->map({-> 0})
    for lnum in range(a:line1, a:line2)
        let columns = split(getline(lnum), '\s\s\+')
        if getline(lnum) !~ '^\s*\%(\([=-]\)\1\+\)\%(\s\+\1\+\)\+\s*$'
            if len(columns) == len(col_width)
                let w = map(copy(columns), {_, v -> strchars(v)})
                call map(col_width, {i, v -> v < w[i] ? w[i] : v})
            endif
        endif
        call add(table, columns)
    endfor
    for row in table
        if row[0] =~ '^\([=-]\)\1*$'
            call map(row, {i, v -> strchars(v) < col_width[i] ? (v . repeat(v[0], col_width[i] - strchars(v))) : repeat(v[0], col_width[i])})
        else
            call map(row, {i, v -> strchars(v) < col_width[i] ? (v . repeat(' ', col_width[i] - strchars(v))) : v})
        endif
    endfor
    call map(table, {_, v -> trim(join(v, '  '))})
    call setline(a:line1, table)
endfunc
