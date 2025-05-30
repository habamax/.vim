vim9script

# insert mode completion
set completepopup=highlight:Pmenu
set completeopt=menuone,popup,noselect,fuzzy
set infercase
set complete=o^7,.^7,w^3,b^3,u^3,t^2

set complete+=FAbbrevCompletor^3
def g:AbbrevCompletor(findstart: number, base: string): any
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
        items->add({ word: m[1], kind: "ab", info: m[2], dup: 1 })
    endfor
    items = items->matchfuzzy(base, {key: "word"})
    return items->empty() ? v:none : items
enddef

set complete+=FRegisterComplete^5
def g:RegisterComplete(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\S\+$')
        if prefix->empty()
            return -2
        endif
        return col('.') - prefix->len() - 1
    endif

    var items = []

    for r in '*+"/=#:%-0123456789abcdefghijklmnopqrstuvwxyz'
        var regtext = trim(getreg(r))
        if !empty(regtext)
            items->add({
                abbr: regtext->slice(0, 30),
                word: regtext,
                kind: '"' .. r,
                info: regtext, dup: 0 })
        endif
    endfor

    items = items->matchfuzzy(base, {key: "word"})
    return items->empty() ? v:none : items
enddef

var instrigger = {
    vim: '\v%(\k|\k-\>|[gvbls]:)$',
    c: '\v%(\k|\k\.|\k-\>)$',
    python: '\v%(\k|\k\.)$',
    gdscript: '\v%(\k|\k\.)$',
    ruby: '\v%(\k|\k\.)$',
    javascript: '\v%(\k|\k\.)$',
}
def InsComplete()
    var trigger = get(instrigger, &ft, '\k$')
    if getcharstr(1) == '' && getline('.')->strpart(0, col('.') - 1) =~ trigger
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

inoremap <silent> <c-e> <c-r>=<SID>SkipTextChangedI()<cr><c-e>
inoremap <silent> <c-y> <c-r>=<SID>SkipTextChangedI()<cr><c-y>
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

augroup inscomplete
    au!
    autocmd TextChangedI * InsComplete()
augroup END


# command line completion
set wildmode=noselect:lastused,full
set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildcharm=<C-@>
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags

def CmdComplete()
    var [cmdline, curpos] = [getcmdline(), getcmdpos()]
    var trigger = '\v%(\w|[*/:.-=]|\s)$'
    var exclude = '\v^(\d+|.*s[/,#].*)$'
    if getchar(1, {number: true}) == 0  # Typehead is empty (no more pasted input)
            && !wildmenumode() && curpos == cmdline->len() + 1
            && cmdline =~ trigger && cmdline !~ exclude # Reduce noise
        feedkeys("\<C-@>", "ti")
        SkipCmdlineChanged()  # Suppress redundant completion attempts
        # Remove <C-@> that get inserted when no items are available
        timer_start(0, (_) => getcmdline()->substitute('\%x00', '', 'g')->setcmdline())
    endif
enddef

def SkipCmdlineChanged(key = ''): string
    set eventignore+=CmdlineChanged
    timer_start(0, (_) => execute('set eventignore-=CmdlineChanged'))
    return key != '' ? ((pumvisible() ? "\<c-e>" : '') .. key) : ''
enddef

cnoremap <expr> <up> SkipCmdlineChanged("\<up>")
cnoremap <expr> <down> SkipCmdlineChanged("\<down>")

augroup cmdcomplete
    au!
    autocmd CmdlineChanged : CmdComplete()
    # autocmd CmdlineEnter : set belloff+=error
    # autocmd CmdlineLeave : set belloff-=error
augroup END
