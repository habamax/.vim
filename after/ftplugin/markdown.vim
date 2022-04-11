vim9script

setl commentstring=<!--%s-->

# header textobject
onoremap <buffer><silent> iP :<C-u>call <sid>HeaderTextObj(v:true)<CR>
onoremap <buffer><silent> aP :<C-u>call <sid>HeaderTextObj(v:false)<CR>
xnoremap <buffer><silent> iP :<C-u>call <sid>HeaderTextObj(v:true)<CR>
xnoremap <buffer><silent> aP :<C-u>call <sid>HeaderTextObj(v:false)<CR>


# Markdown header text object
# * inner object is the text between prev section header(excluded) and the next
#   section of the same level(excluded) or end of file.
# * an object is the text between prev section header(included) and the next section of the same
#   level(excluded) or end of file.
def HeaderTextObj(inner: bool)
    var lnum_start = search('^#\+\s\+[^[:space:]=]', "ncbW")
    if lnum_start
        var lvlheader = matchstr(getline(lnum_start), '^#\+')
        var lnum_end = search('^#\{1,' .. len(lvlheader) .. '}\s', "nW")
        if !lnum_end
            lnum_end = search('\%$', 'cnW')
        else
            lnum_end -= 1
        endif
        if inner && getline(lnum_start + 1) !~ '^#\+\s\+[^[:space:]=]'
            lnum_start += 1
        endif

        exe ":" .. lnum_end
        normal! V
        exe ":" .. lnum_start
    endif
enddef
