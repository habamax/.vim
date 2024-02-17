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

inorea <buffer> k: :kbd:``<left><C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> no: .. note::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> wa: .. warning::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> ad: .. admonition::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> at: .. attention::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> ca: .. caution::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> da: .. DANGER::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> er: .. error::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> hi: .. hint::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> im: .. important::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> ti: .. tip::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> si: .. sidebar::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> to: .. topic::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> ep: .. epigraph::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> hl: .. highlights::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> co: .. code::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> fi: .. figure::<C-R>=misc#Eatchar('\s')<CR>
inorea <buffer> i: .. image::

import autoload 'popup.vim'
def Toc()
    var toc: list<dict<any>> = []
    var lvl_ch: list<string> = []
    var toc_num: list<number> = []
    var plvl = 0
    var pnr = 0
    for nr in range(1, line('$'))
        var line = getline(nr)
        var pline = getline(nr - 1)
        var ppline = getline(nr - 2)
        if line =~ '^\([-="#*~`.]\)\1*\s*$'
            if pline =~ '\S' && ppline == line && nr - 2 != pnr
                var lvl = lvl_ch->index(line[0] .. line[0])
                if lvl == -1
                    lvl_ch->add(line[0] .. line[0])
                    toc_num->add(1)
                    lvl = lvl_ch->len() - 1
                else
                    if lvl > plvl
                        toc_num[lvl] = 1
                    else
                        toc_num[lvl] += 1
                    endif
                endif
                plvl = lvl
                pnr = nr
                toc->add({lvl: lvl, toc_num: toc_num[: lvl], text: $'{pline->trim()} ({nr - 1})', linenr: nr - 1})
            elseif pline =~ '^\S' && pline !~ '^\([-"=#*~`.]\)\1*\s*$'
                var lvl = lvl_ch->index(line[0])
                if lvl == -1
                    lvl_ch->add(line[0])
                    toc_num->add(1)
                    lvl = lvl_ch->len() - 1
                else
                    if lvl > plvl
                        toc_num[lvl] = 1
                    else
                        toc_num[lvl] += 1
                    endif
                endif
                plvl = lvl
                pnr = nr
                toc->add({lvl: lvl, toc_num: toc_num[: lvl], text: $'{pline->trim()} ({nr - 1})', linenr: nr - 1})
            endif
        endif
    endfor

    var title = toc->reduce((acc, v) => v.lvl == 0 ? acc + 1 : acc, 0) == 1 ? 1 : 0
    var subtitle = toc->reduce((acc, v) => v.lvl == 1 ? acc + 1 : acc, 0) == 1 ? 1 : 0

    g:toc = toc
    for t in toc
        var toc_num_str = t.toc_num[title + subtitle : ]->join('.')
        t.text = repeat("  ", t.lvl - title - subtitle) .. $"{toc_num_str} {t.text}"
    endfor

    popup.FilterMenu("TOC", toc,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, 'syn match FilterMenuLineNr "(\d\+)$"')
            win_execute(winid, 'syn match FilterMenuSecNum "^\s*\(\d\+\.\)*\(\d\+\)"')
            hi def link FilterMenuLineNr Comment
            hi def link FilterMenuSecNum Title
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>

nnoremap <buffer> <space><space>oh :RstViewHtml<CR>
nnoremap <buffer> <space><space>op :RstViewPdf<CR>
nnoremap <buffer> <space><space>cp :Rst2Pdf<CR>
nnoremap <buffer> <space><space>ch :Rst2Html<CR>
nnoremap <buffer> <F5> <scriptcmd>exe "Sh" &makeprg<cr>

def Rst2Html(locale: string = "")
    if !empty(locale)
        b:rst2html_opts = g:rst2html_opts .. " --language=" .. locale
    else
        b:rst2html_opts = g:rst2html_opts
    endif
    compiler rst2html
    if exists(":Sh") == 2
        exe "Sh" &makeprg
    else
        make
    endif
enddef

command -buffer -nargs=? -complete=locale Rst2Html Rst2Html(<f-args>)

import autoload 'os.vim'
command -buffer Rst2Pdf make | call os.Exe(printf('rst2pdf "%s" -o "%s"',
      \ expand("%:p"),
      \ expand("%:p:r") .. '.pdf'
      \ ))
# var chrome = ''
# if has("win32")
#     chrome = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
# else
#     chrome = 'chromium'
# endif
# if !chrome->empty()
#     command -buffer Rst2Pdf make | call os.Exe(printf('"%s" %s %s "%s"',
#           \ chrome,
#           \ '--headless --disable-gpu --print-to-pdf-no-header',
#           \ '--print-to-pdf="' .. expand("%:p:r") .. '.pdf"',
#           \ expand("%:p:r") .. '.html'
#           \ ))
# endif

command -buffer RstViewHtml :call os.Open(expand("%:p:r") .. '.html')
command -buffer RstViewPdf :call os.Open(expand("%:p:r") .. '.pdf')

def HlCheckmark()
    exe 'syn match rstCheckDone /\%(' .. &l:formatlistpat .. '\)\@<=✓/ containedin=TOP'
    exe 'syn match rstCheckReject /\%(' .. &l:formatlistpat .. '\)\@<=✗/ containedin=TOP'
    hi link rstCheckDone Added
    hi link rstCheckReject Removed
enddef

augroup checkmark | au!
    au Syntax rst call HlCheckmark()
    au Colorscheme * call HlCheckmark()
augroup END
