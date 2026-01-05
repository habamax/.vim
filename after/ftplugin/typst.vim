vim9script

&l:makeprg = $"typst compile --root={expand("~/docs")} {expand("%")}"
b:undo_ftplugin ..= ' | setl makeprg<'

def BuildPDF(watch: bool = false)
    if watch
        exe $"Term typst watch --root={expand("~/docs")} {expand("%:p")}"
    else
        exe "Make"
    endif
enddef

nnoremap <buffer> <F5> <cmd>update<cr><scriptcmd>BuildPDF()<cr>
nnoremap <buffer> <space><F5> <cmd>update<cr><scriptcmd>BuildPDF(true)<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space><F5>"'
