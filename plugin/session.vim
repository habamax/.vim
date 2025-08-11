vim9script

# save and load sessions
if !isdirectory($'{$MYVIMDIR}.data/sessions')
    mkdir($'{$MYVIMDIR}.data/sessions', "p")
endif

var sessions_cache: string
export def CompleteReset()
    sessions_cache = ""
enddef

def SessionComplete(_, _, _): string
    if empty(sessions_cache)
        sessions_cache = globpath($'{$MYVIMDIR}.data/sessions/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
    endif
    return sessions_cache
enddef

command! -nargs=1 -complete=custom,SessionComplete SaveSession :exe $'mksession! {$MYVIMDIR}.data/sessions/<args>'
command! -nargs=1 -complete=custom,SessionComplete LoadSession :%bd <bar> exe $'so {$MYVIMDIR}.data/sessions/<args>'
