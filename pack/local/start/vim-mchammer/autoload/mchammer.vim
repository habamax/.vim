vim9script

# WIP

# test
xnoremap <C-j> <ScriptCmd>mchammer#AddCursor()<CR>
nnoremap <C-j> <ScriptCmd>mchammer#AddCursor()<CR>

augroup mchammer | au!
    au ModeChanged [vV\x16]*:n* call ClearCursors()
    au ModeChanged i*:n* call UpdateCursors()
augroup END

# hello world hey hello
# world hello
# this world hello is now

# prop_type_add('mchammer', {highlight: 'Visual'})

export def AddCursor()
    noautocmd exe "normal! \<ESC>"
    var pos = getcurpos()
    var line = getline('.')
    var wordLeft = matchstr(line, '\k\+\%.c')
    var wordRight = matchstr(line, '\%.c\k\+')
    # v#Popup("Left " .. wordLeft .. " Right " .. wordRight)
    # if empty(wordRight) | return | endif
    if search(wordLeft .. wordRight, "W") > 0
        search(wordRight, "cW")
        prop_add(pos[1], pos[2], {length: 1, type: 'mchammer'})
    endif
    noautocmd exe "normal! \<C-v>"
enddef


def ClearCursors()
    prop_remove({type: "mchammer", all: 1})
enddef


def UpdateCursors()
    var mc_mark = prop_find({type: "mchammer"}, "b")
    while !empty(mc_mark)
        UpdateLine(mc_mark.lnum)
        mc_mark = prop_find({type: "mchammer"}, "b")
    endwhile
enddef


def UpdateLine(lnum: number)
    var mc_marks = prop_list(lnum, {types: ["mchammer"]})
    while !empty(mc_marks)
        cursor(lnum, mc_marks[0].col)
        normal! .
        prop_remove({type: "mchammer"}, lnum)
        mc_marks = prop_list(lnum, {types: ["mchammer"]})
    endwhile
enddef

# hello world hey hello world hello
# world hello
# this world hello is now
