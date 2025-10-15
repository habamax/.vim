vim9script

finish

set ac complete=FTestComplete
var prefix: string
var nooption: bool = false

def g:TestComplete(findstart: number, base: string): any
    if findstart > 0
        prefix = getline('.')->strpart(0, col('.') - 1)
        if prefix =~ '\vse%[t]\s+(\k+\s+)*no\k*$' && !nooption
            nooption = true
            return -4
        endif
        var keyword = prefix->matchstr('\k\+$')
        if nooption
            return 4
        else
            return prefix->len() - keyword->len()
        endif
    endif

    echow prefix "::::" base
    var items = []
    if getcompletiontype(prefix) == 'command'
        items = getcompletion(base, 'command')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Command', dup: 0}))
    elseif getcompletiontype(prefix) == 'option'
        items = getcompletion(base, 'option')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Option', dup: 0}))
    elseif nooption
        items = getcompletion('', 'option')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Option', dup: 0}))
        echow items
        nooption = false
    endif

    return items->empty() ? v:none : {words: items, refresh: "always"}
enddef

