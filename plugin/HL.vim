vim9script

# better H/L

def L()
    var line = line('.')
    normal! L
    if line == line('$')
        normal! zb
    elseif line == line('.')
        normal! zt
    endif
enddef

def H()
    var line = line('.')
    normal! H
    if line == line('.')
        normal! zb
    endif
enddef

noremap L <ScriptCmd>L()<CR>
noremap H <ScriptCmd>H()<CR>
