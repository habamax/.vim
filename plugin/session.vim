vim9script

# save and load sessions
if !isdirectory($'{$MYVIMDIR}.data/sessions')
    mkdir($'{$MYVIMDIR}.data/sessions', "p")
endif

var sessions_cache: list<string>
augroup CmdCompleteResetSession
    au!
    au CmdlineEnter : sessions_cache = []
augroup END

def SessionComplete(arg: string, _, _): list<string>
    if empty(sessions_cache)
        sessions_cache = globpath($'{$MYVIMDIR}.data/sessions/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))
    endif
    if empty(arg)
        return sessions_cache
    else
        return sessions_cache->matchfuzzy(arg)
    endif
enddef

command! -nargs=_ -complete=customlist,SessionComplete SaveSession :exe $'mksession! {$MYVIMDIR}.data/sessions/<args>'
command! -nargs=_ -complete=customlist,SessionComplete LoadSession :%bd <bar> exe $'so {$MYVIMDIR}.data/sessions/<args>'
