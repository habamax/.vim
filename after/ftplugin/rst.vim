vim9script

if exists('b:undo_ftplugin')
    b:undo_ftplugin ..= "|setl tw< sw< fo<"
else
    b:undo_ftplugin = "setl tw< sw< fo<"
endif

setlocal textwidth=80
setlocal formatoptions=tnc
setlocal shiftwidth=2

compiler rst2html


import autoload 'popup.vim'
def Toc()
    var toc: list<dict<any>> = []
    var lvl_ch: list<string> = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        var pline = getline(nr - 1)
        var ppline = getline(nr - 2)
        if line =~ '^\([-=#*~]\)\1*\s*$'
            if pline =~ '\S' && ppline == line
                var lvl = lvl_ch->index(line[0] .. line[0])
                if lvl == -1
                    lvl_ch->add(line[0] .. line[0])
                    lvl = lvl_ch->len() - 1
                endif
                toc->add({text: $'{repeat("\t", lvl)}{pline->trim()} ({nr})', linenr: nr})
            elseif pline =~ '^\S'
                var lvl = lvl_ch->index(line[0])
                if lvl == -1
                    lvl_ch->add(line[0])
                    lvl = lvl_ch->len() - 1
                endif
                toc->add({text: $'{repeat("\t", lvl)}{pline->trim()} ({nr})', linenr: nr})
            endif
        endif
    endfor

    popup.FilterMenu("TOC", toc,
        (res, key) => {
            exe $":{res.linenr - 1}"
        },
        (winid) => {
            win_execute(winid, "setl ts=4 list")
            win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
            hi def link FilterMenuLineNr Comment
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>

nnoremap <buffer> <space><space>oh :RstViewHtml<CR>
nnoremap <buffer> <space><space>op :RstViewPdf<CR>
nnoremap <buffer> <space><space>cp :Rst2Pdf<CR>
nnoremap <buffer> <space><space>ch :Rst2Html<CR>

def Rst2Html(locale: string = "")
    if !empty(locale)
        b:rst2html_opts = g:rst2html_opts .. " --language=" .. locale
    else
        b:rst2html_opts = g:rst2html_opts
    endif
    compiler rst2html
    make
enddef

command -buffer -nargs=? -complete=locale Rst2Html Rst2Html(<f-args>)

var chrome = ''
if executable('google-chrome')
    chrome = 'google-chrome'
elseif executable('C:/Program Files/Google/Chrome/Application/chrome.exe')
    chrome = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
endif

import autoload 'os.vim'
if !chrome->empty()
    command -buffer Rst2Pdf make | call os.Exe(printf('"%s" %s %s "%s"',
          \ chrome,
          \ '--headless --disable-gpu --print-to-pdf-no-header',
          \ '--print-to-pdf="' .. expand("%:p:r") .. '.pdf"',
          \ expand("%:p:r") .. '.html'
          \ ))
endif

command -buffer RstViewHtml :call os.Open(expand("%:p:r") .. '.html')
command -buffer RstViewPdf :call os.Open(expand("%:p:r") .. '.pdf')

def HlCheckmark()
    exe 'syn match rstCheckDone /\%(' .. &l:formatlistpat .. '\)\@<=✓/ nextgroup=rstCheckMarkDate skipwhite containedin=rstMaybeSection'
    exe 'syn match rstCheckReject /\%(' .. &l:formatlistpat .. '\)\@<=✗/ nextgroup=rstCheckMarkDate skipwhite containedin=rstMaybeSection'
    syn match rstCheckMarkDate /(\d\{4}-\d\d-\d\d)/ contained
    if &background == 'dark'
      hi rstCheckDone ctermfg=119 guifg=#87FF5F gui=bold cterm=bold
      hi rstCheckReject ctermfg=203 guifg=#FF5F5F gui=bold cterm=bold
      hi link rstCheckMarkDate Comment
    else
      hi rstCheckDone ctermfg=28 guifg=#008700 gui=bold cterm=bold
      hi rstCheckReject ctermfg=196 guifg=#FF0000 gui=bold cterm=bold
      hi link rstCheckMarkDate Comment
    endif
enddef

augroup checkmark | au!
    au Syntax rst call HlCheckmark()
    au Colorscheme * call HlCheckmark()
augroup END


# command! -buffer -range RstFixTable :call s:fixSimpleTable(<line1>, <line2>)

# func! s:fixSimpleTable(line1, line2) abort
#     let table = []
#     if getline(a:line1) !~ '^\s*\%(===\+\)\%(\s\+===\+\)\+\s*$'
#         return
#     endif
#     let col_width = split(getline(a:line1), '\s\s\+')->map({-> 0})
#     for lnum in range(a:line1, a:line2)
#         let columns = split(getline(lnum), '\s\s\+')
#         if getline(lnum) !~ '^\s*\%(\([=-]\)\1\+\)\%(\s\+\1\+\)\+\s*$'
#             if len(columns) == len(col_width)
#                 let w = map(copy(columns), {_, v -> strchars(v)})
#                 call map(col_width, {i, v -> v < w[i] ? w[i] : v})
#             endif
#         endif
#         call add(table, columns)
#     endfor
#     for row in table
#         if row[0] =~ '^\([=-]\)\1*$'
#             call map(row, {i, v -> strchars(v) < col_width[i] ? (v . repeat(v[0], col_width[i] - strchars(v))) : repeat(v[0], col_width[i])})
#         else
#             call map(row, {i, v -> strchars(v) < col_width[i] ? (v . repeat(' ', col_width[i] - strchars(v))) : v})
#         endif
#     endfor
#     call map(table, {_, v -> trim(join(v, '  '))})
#     call setline(a:line1, table)
# endfunc


# func! s:section_delimiter_adjust() abort
#     let section_delim = '^\([=`:."' . "'" . '~^_*+#-]\)\1*$'
#     let cline = getline('.')
#     if cline =~ '^\s*$' | return | endif
#     if cline !~ section_delim && cline !~ '^\s\+\S'
#         let nline = getline(line('.') + 1)
#         let pline = getline(line('.') - 1)
#         if pline =~ '^\s*$' && nline =~ section_delim
#             call setline(line('.') + 1, repeat(nline[0], strchars(cline)))
#         elseif pline =~ section_delim && nline =~ section_delim && pline[0] == nline[0]
#             call setline(line('.') + 1, repeat(nline[0], strchars(cline)))
#             call setline(line('.') - 1, repeat(pline[0], strchars(cline)))
#         endif
#     endif
# endfunc

# augroup rst_section | au!
#     au InsertLeave <buffer> :call s:section_delimiter_adjust()
# augroup END
