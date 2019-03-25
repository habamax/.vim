setl commentstring=<!--%s-->

compiler pandoc2pdf

" open files
nnoremap <buffer> <leader>op :silent !start %:p:r.pdf<CR>
nnoremap <buffer> <leader>od :silent !start %:p:r.docx<CR>
nnoremap <buffer> <leader>oh :silent !start %:p:r.html<CR>

function! MarkdownFold()
  let line = getline(v:lnum)

  " Regular headers
  let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
  if depth > 0
    return ">" . depth
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
endfunction
