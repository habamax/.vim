if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl tw< sw< fo<"
else
    let b:undo_ftplugin = "setl tw< sw< fo<"
endif

setlocal textwidth=80
setlocal formatoptions=tnc
setlocal shiftwidth=2

compiler rst2html

" TODO: add it to undo ftplugin
nnoremap <buffer> <space><space>oh :RstViewHtml<CR>
nnoremap <buffer> <space><space>op :RstViewPdf<CR>
nnoremap <buffer> <space><space>cp :Rst2Pdf<CR>
nnoremap <buffer> <space><space>ch :Rst2Html<CR>

command -buffer -nargs=? -complete=locale Rst2Html call s:rst2html(<f-args>)

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

command -buffer Rst2Pdf make | exe os#exe(printf('"%s" %s %s "%s"',
      \ 'C:/Program Files/Google/Chrome/Application/chrome.exe',
      \ '--headless --disable-gpu --print-to-pdf-no-header',
      \ '--print-to-pdf="' . expand("%:p:r") . '.pdf"',
      \ expand("%:p:r") . '.html'
      \ ))

command -buffer RstViewHtml :call os#open(expand("%:p:r").'.html')
command -buffer RstViewPdf :call os#open(expand("%:p:r").'.pdf')

func! s:hl_checkmark() abort
    exe 'syn match rstCheckDone /\%('.&l:formatlistpat.'\)\@<=✓/ nextgroup=rstCheckMarkDate skipwhite containedin=rstMaybeSection'
    exe 'syn match rstCheckReject /\%('.&l:formatlistpat.'\)\@<=✗/ nextgroup=rstCheckMarkDate skipwhite containedin=rstMaybeSection'
    syn match rstCheckMarkDate /(\d\{4}-\d\d-\d\d)/ contained
    if &background == 'dark'
      hi rstCheckDone ctermfg=108 guifg=#87AF87 gui=bold cterm=bold
      hi rstCheckReject ctermfg=167 guifg=#d75F5F gui=bold cterm=bold
      hi rstCheckMarkDate ctermfg=240 guifg=#585858
    else
      hi rstCheckDone ctermfg=28 guifg=#008700 gui=bold cterm=bold
      hi rstCheckReject ctermfg=124 guifg=#AF0000 gui=bold cterm=bold
      hi rstCheckMarkDate ctermfg=246 guifg=#949494
    endif
endfunc

augroup checkmark | au!
    au Syntax rst call s:hl_checkmark()
    au Colorscheme * call s:hl_checkmark()
augroup END


command! -buffer -range RstFixTable :call s:fixSimpleTable(<line1>, <line2>)

func! s:fixSimpleTable(line1, line2) abort
    let table = []
    if getline(a:line1) !~ '^\s*\%(===\+\)\%(\s\+===\+\)\+\s*$'
        return
    endif
    let col_width = split(getline(a:line1), '\s\s\+')->map({-> 0})
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


func! s:section_delimiter_adjust() abort
    let section_delim = '^\([=`:."' . "'" . '~^_*+#-]\)\1*$'
    let cline = getline('.')
    if cline =~ '^\s*$' | return | endif
    if cline !~ section_delim && cline !~ '^\s\+\S'
        let nline = getline(line('.') + 1)
        let pline = getline(line('.') - 1)
        if pline =~ '^\s*$' && nline =~ section_delim
            call setline(line('.') + 1, repeat(nline[0], strchars(cline)))
        elseif pline =~ section_delim && nline =~ section_delim && pline[0] == nline[0]
            call setline(line('.') + 1, repeat(nline[0], strchars(cline)))
            call setline(line('.') - 1, repeat(pline[0], strchars(cline)))
        endif
    endif
endfunc

augroup rst_section | au!
    au InsertLeave <buffer> :call s:section_delimiter_adjust()
augroup END
