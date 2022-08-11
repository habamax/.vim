vim9script

setl textwidth=80
setl keywordprg=:help

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

def Fold()
    silent! norm! zf/^enddef/e
enddef

import autoload 'popup.vim'
def InterestingThings()
    var view = winsaveview()
    var h_s: string
    redir => h_s
    :silent g/\<def \k\+(/p l#
    redir END
    winrestview(view)
    var h_list = h_s->split("\\s*\n\\s*")->mapnew((_, v) => {
        var cols = v->split('^\d\+\zs\s\+')
        return {text: cols[1], linenr: cols[0]}
    })
    popup.FilterMenu("Vim Things", h_list,
        (res, key) => {
            exe $":{res.linenr}"
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>InterestingThings()<CR>

nnoremap <silent><buffer> <F2> :g#^def\s#silent! exe "norm! zd" \| call <sid>Fold()<CR>
nnoremap <buffer> <F5> :source<CR>
