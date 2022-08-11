vim9script

setl commentstring=<!--%s-->

# header textobject
onoremap <buffer><silent> iP <scriptcmd>HeaderTextObj(true)<CR>
onoremap <buffer><silent> aP <scriptcmd>HeaderTextObj(false)<CR>
xnoremap <buffer><silent> iP <esc><scriptcmd>HeaderTextObj(true)<CR>
xnoremap <buffer><silent> aP <esc><scriptcmd>HeaderTextObj(false)<CR>

import autoload 'popup.vim'

def MarkdownHeading()
    var view = winsaveview()
    var h_s: string
    redir => h_s
    :silent! g/^\(#\+\s\S\+\)\|\(\S\+.*\n\(=\+\|-\+\)\)$/p l#
    redir END
    winrestview(view)
    var h_list = h_s->split("\\s*\n\\s*")->mapnew((_, v) => {
        var cols = v->split('^\d\+\zs\s\+')
        var lvl = 0
        var next_linenr = cols[0]->str2nr() + 1
        if getline(next_linenr) =~ '^=\+'
            lvl = 0
        elseif getline(next_linenr) =~ '^-\+'
            lvl = 1
        else
            # TODO: check syntax?
            lvl = matchstr(cols[1], '^#\+')->len() - 1
        endif
        return {text: $'{repeat("\t", lvl)}{cols[1]->trim("# ")}', linenr: cols[0]}
    })
    popup.FilterMenu("Heading", h_list,
        (res, key) => {
            exe $":{res.linenr}"
        },
        (winid) => {
            win_execute(winid, "setl ts=4 list")
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>MarkdownHeading()<CR>


# Markdown header text object
# * inner object is the text between prev section header(excluded) and the next
#   section of the same level(excluded) or end of file.
# * an object is the text between prev section header(included) and the next section of the same
#   level(excluded) or end of file.
def HeaderTextObj(inner: bool)
    var lnum_start = search('^#\+\s\+[^[:space:]=]', "ncbW")
    if lnum_start > 0
        var lvlheader = matchstr(getline(lnum_start), '^#\+')
        var lnum_end = search('^#\{1,' .. len(lvlheader) .. '}\s', "nW")
        if lnum_end == 0
            lnum_end = search('\%$', 'cnW')
        else
            lnum_end -= 1
        endif
        if inner && getline(lnum_start + 1) !~ '^#\+\s\+[^[:space:]=]'
            lnum_start += 1
        endif

        echom lnum_start lnum_end
        exe $":{lnum_end}"
        normal! V
        exe $":{lnum_start}"
    endif
enddef
