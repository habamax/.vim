vim9script

for r in 'abcdefghijklmnopqrstuvwxyz'
    sign_define($"mark_'{r}", {text: $"'{r}", culhl: "CursorLineNr", texthl: "LineNr"})
    exe $"nnoremap m{r} m{r}<scriptcmd>UpdateMarks()<CR>"
endfor
for r in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    sign_define($"mark_'{r}", {text: $"'{r}", culhl: "CursorLineNr", texthl: "LineNr"})
    exe $"nnoremap m{r} m{r}<scriptcmd>UpdateVisibleBuffersMarks()<CR>"
endfor

def UpdateMarks(buffer: number = bufnr())
    sign_unplace("marks", {buffer: buffer})
    var local_marks = getmarklist(buffer)->filter((_, v) => v.mark =~ '[[:alpha:]]')
    var global_marks = getmarklist()->filter((_, v) => v.mark =~ '[[:alpha:]]' && v.pos[0] == buffer)
    local_marks->extendnew(global_marks)->foreach((_, v) => {
        sign_place(0, "marks", $"mark_{v.mark}", v.pos[0], {lnum: v.pos[1]})
    })
enddef

def UpdateVisibleBuffersMarks()
    var visible_buffers = getbufinfo({buflisted: 1, bufloaded: 1})
    visible_buffers->foreach((_, v) => {
        if !empty(v.windows)
            UpdateMarks(v.bufnr)
        endif
    })
enddef

augroup mark_signs
    au!
    au BufEnter * UpdateMarks()
augroup END
