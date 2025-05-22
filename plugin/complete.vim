vim9script

set completepopup=highlight:Pmenu
set completeopt=menuone,popup,noselect,fuzzy,nearest
set infercase

set complete+=fAbbrevCompletor

def LspSetup()
    if !exists("g:loaded_lsp")
        return
    endif

    def g:LspCompletor(maxitems: number, findstart: number, base: string): any
        if findstart == 1
            return g:LspOmniFunc(findstart, base)
        endif

        var data = g:LspOmniFunc(findstart, base)
        var words = []
        if type(data) == v:t_list
             words = data->slice(0, maxitems)
        endif

        return {words: words, refresh: 'always'}
    enddef

    set complete+=ffunction("g:LspCompletor"\\,[10])
    g:LspOptionsSet({ autoComplete: false, omniComplete: true })
enddef

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
            items->add({ word: m[1], info: m[2], dup: 1 })
        endif
    endfor
    return items->empty() ? v:none :
        items->sort((v1, v2) => v1.word < v2.word ? -1 : v1.word ==# v2.word ? 0 : 1)
enddef

def InsComplete()
    if getcharstr(1) == '' && getline('.')->strpart(0, col('.') - 1) =~ '\k$'
        SkipTextChangedIEvent()
        feedkeys("\<c-n>", "n")
    endif
enddef

def SkipTextChangedIEvent(): string
    # Suppress next event caused by <c-e> (or <c-n> when no matches found)
    set eventignore+=TextChangedI
    timer_start(1, (_) => {
        set eventignore-=TextChangedI
    })
    return ''
enddef

augroup autocomplete
    au!
    autocmd VimEnter * LspSetup()
    autocmd TextChangedI * InsComplete()
augroup END

inoremap <silent> <c-e> <c-r>=<SID>SkipTextChangedIEvent()<cr><c-e>
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
