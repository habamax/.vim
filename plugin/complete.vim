vim9script

set completepopup=highlight:Normal
set completeopt=menuone,popup,noselect,fuzzy,nearest
set infercase
set complete=.,w^10,b^10,u^10,t^10
set complete+=fAbbrevCompletor

if exists("g:loaded_lsp")
    def g:LspCompletor(maxitems: number, findstart: number, base: string): any
        if findstart == 1
            var startcol = g:LspOmniFunc(findstart, base)
            return startcol < 0 ? startcol : startcol + 1
        elseif findstart == 2
            return g:LspOmniCompletePending() ? 0 : 1
        endif

        var items = g:LspOmniFunc(findstart, base)
        if items->empty()
            return v:none
        endif
        items = items->slice(0, maxitems)
        return items
    enddef

    set complete+=ffunction("g:LspCompletor"\\,[10])
    g:LspOptionsSet({ autoComplete: false, omniComplete: true })
endif

def! g:AbbrevCompletor(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\S\+$')
        if prefix->empty()
            return -2
        endif
        return col('.') - prefix->len() - 1
    endif
    var lines = execute('ia', 'silent!')
    if lines =~? gettext('No abbreviation found')
        return v:none  # Suppresses warning message
    endif
    var items = []
    for line in lines->split("\n")
        var m = line->matchlist('\v^i\s+\zs(\S+)\s+(.*)$')
        if m->len() > 2 && m[1]->stridx(base) == 0
            items->add({ word: m[1], kind: "abbr", info: m[2], dup: 1 })
        endif
    endfor
    return items->empty() ? v:none :
        items->sort((v1, v2) => v1.word < v2.word ? -1 : v1.word ==# v2.word ? 0 : 1)
enddef

def InsComplete()
    if getcharstr(1) == '' && getline('.')->strpart(0, col('.') - 1) =~ '\k$'
        SkipTextChangedI()
        feedkeys("\<c-n>", "n")
    endif
enddef

def SkipTextChangedI(): string
    # Suppress next event caused by <c-e> (or <c-n> when no matches found)
    set eventignore+=TextChangedI
    timer_start(1, (_) => {
        set eventignore-=TextChangedI
    })
    return ''
enddef

augroup autocomplete
    au!
    autocmd TextChangedI * InsComplete()
augroup END

inoremap <silent> <c-e> <c-r>=<SID>SkipTextChangedI()<cr><c-e>
inoremap <silent> <c-y> <c-r>=<SID>SkipTextChangedI()<cr><c-y>
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
