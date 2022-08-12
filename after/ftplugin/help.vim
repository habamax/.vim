vim9script

b:undo_ftplugin ..= ' | exe "nunmap <buffer> <cr>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> o"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> u"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> J"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'

nnoremap <buffer> <cr> <C-]>
nnoremap <buffer> o <C-]>
nnoremap <buffer> u <C-t>
nnoremap <buffer> J <cmd>call search('\|[^\|[:space:]]\+\|', 'z')<cr>
nnoremap <buffer> K <cmd>call search('\|[^\|[:space:]]\+\|', 'zb')<cr>

import autoload 'popup.vim'

def Toc()
    var view = winsaveview()
    var h_s: string
    redir => h_s
    :silent! g/\(^\S\+.*\~\s*$\)\|\(^\*[^*]\+\*\s\+.*$\)\|\(^\u[[:punct:][:space:][:upper:]]\+\(\*[^*]\+\*\)\?\s*$\)/p l#
    redir END
    winrestview(view)
    var h_list = h_s->split("\\s*\n\\s*")->mapnew((_, v) => {
        var cols = v->split('^\d\+\zs\s\+')
        return {text: $'{cols[1]->trim("~ ")}', linenr: cols[0]}
    })
    popup.FilterMenu("Heading", h_list,
        (res, key) => {
            exe $":{res.linenr}"
        },
        (winid) => {
            win_execute(winid, "setl ts=4 list")
        })
enddef

nnoremap <buffer> <space>z <scriptcmd>Toc()<CR>
