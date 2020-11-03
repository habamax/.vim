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
    let lnum_start = search('^#\+\s\+[^[:space:]=]', "ncbW")
    if lnum_start
        let lvlheader = matchstr(getline(lnum_start), '^#\+')
        let lnum_end = search('^#\{1,'..len(lvlheader)..'}\s', "nW")
        if !lnum_end
            let lnum_end = search('\%$', 'nW')
        else
            let lnum_end -= 1
        endif
        if a:inner && getline(lnum_start + 1) !~ '^#\+\s\+[^[:space:]=]'
            let lnum_start += 1
        endif

        exe lnum_end
        normal! V
        exe lnum_start
    endif
endfunc
