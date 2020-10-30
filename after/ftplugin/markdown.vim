setl commentstring=<!--%s-->

compiler pandoc2pdf

" open files
nnoremap <buffer> <space>op :silent !start %:p:r.pdf<CR>
nnoremap <buffer> <space>od :silent !start %:p:r.docx<CR>
nnoremap <buffer> <space>oh :silent !start %:p:r.html<CR>

"" header textobject
onoremap <buffer><silent> ih :<C-u>call <sid>header_textobj(v:true)<CR>
onoremap <buffer><silent> ah :<C-u>call <sid>header_textobj(v:false)<CR>
xnoremap <buffer><silent> ih :<C-u>call <sid>header_textobj(v:true)<CR>
xnoremap <buffer><silent> ah :<C-u>call <sid>header_textobj(v:false)<CR>

func! MarkdownFold()
    let line = getline(v:lnum)

    " Regular headers
    let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
    if depth > 0
        " check syntax, it should be markdownH1-6
        let syncode = synstack(v:lnum, 1)
        if len(syncode) > 0 && synIDattr(syncode[0], 'name') =~ 'markdownH[1-6]'
            return ">" . depth
        endif
    endif

    " Setext style headings
    let prevline = getline(v:lnum - 1)
    let nextline = getline(v:lnum + 1)
    if (line =~ '^.\+$') && (nextline =~ '^=\+$') && (prevline =~ '^\s*$')
        return ">1"
    endif

    if (line =~ '^.\+$') && (nextline =~ '^-\+$') && (prevline =~ '^\s*$')
        return ">2"
    endif

    " frontmatter
    if (v:lnum == 1) && (line =~ '^----*$')
        return ">1"
    endif

    return "="
endfunc



"" Markdown header text object
" * inner object is the text between prev section header(excluded) and the next
"   section of the same level(excluded) or end of file.
" * an object is the text between prev section header(included) and the next section of the same
"   level(excluded) or end of file.
func! s:header_textobj(inner) abort
    if search('^#\+\s\+[^[:space:]=]', "bcW")
        let lvlheader = matchstr(getline('.'), '^=\+')
        if a:inner
            normal! j
            " headers are followed one by one
            " # header 1
            " # header 2
            " Do not select inner anything as there is not inner part of it.
            if getline('.') =~ '^#\+\s\+[^[:space:]=]'
                normal! k
                return
            endif
        endif

        normal! V

        if search('^#\{1,'..len(lvlheader)..'}\s', "W")
            normal! k
        else
            call search('\%$', 'W')
        endif
    endif
endfunc
