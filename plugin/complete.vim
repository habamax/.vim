vim9script

# insert mode completion
set completepopup=highlight:Pmenu
set completeopt=menuone,popup,noselect,fuzzy
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,u^3

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
    items = items->matchfuzzy(base, {key: "word", camelcase: false})
    return items->empty() ? v:none : items
enddef

const MAX_REG_LENGTH = 50
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

    for r in '"/=#:%-0123456789abcdefghijklmnopqrstuvwxyz'
        var text = trim(getreg(r))
        var abbr = text->slice(0, MAX_REG_LENGTH)->substitute('\n', '⏎', 'g')
        var info = ""
        if text->len() > MAX_REG_LENGTH
            abbr ..= "…"
            info = text
        endif
        if !empty(text)
            items->add({
                abbr: abbr,
                word: text,
                kind: 'R',
                menu: '"' .. r,
                info: info,
                dup: 0
            })
        endif
    endfor

    items = items->matchfuzzy(base, {key: "word", camelcase: false})
    return items->empty() ? v:none : items
enddef

set complete^=FLspCompletor^7
def g:LspCompletor(findstart: number, base: string): any
    if !exists('*g:LspOmniFunc')
        return -2 # cancel but stay in completion mode
    endif
    var line = getline('.')->strpart(0, col('.') - 1)
    if line =~ '\s$'
        return -2
    endif
    if findstart == 1
        var startcol = g:LspOmniFunc(findstart, base)
        return startcol < 0 ? startcol : startcol + 1
    elseif findstart == 2
        return g:LspOmniCompletePending() ? 0 : 1
    endif
    return g:LspOmniFunc(findstart, base)
enddef

var instrigger = {
    vim: '\v%(\k|\k-\>|[gvbls]:)$',
    c: '\v%(\k|\k\.|\k-\>)$',
    python: '\v%(\k|\k\.)$',
    gdscript: '\v%(\$|\k|\k\.)$',
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
    # Suppress next event caused by <c-e>/<c-y> (or <c-n> when no matches found)
    set eventignore+=TextChangedI
    timer_start(1, (_) => {
        set eventignore-=TextChangedI
    })
    return ''
enddef

inoremap <silent> <c-e> <scriptcmd>SkipTextChangedI()<cr><c-e>
inoremap <silent> <c-y> <scriptcmd>SkipTextChangedI()<cr><c-y>
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
    var [cmdline, curpos, cmdmode] = [getcmdline(), getcmdpos(), expand('<afile>') == ':']
    var trigger_char = '\v%(\w|[*/:.-]|\s)$'
    # Exclude numeric range and substitute
    var not_trigger_char = '\v^(%(\d|,|\+|-)+$)|%(s[[:punct:]])'
    # Typehead is empty, no more pasted input
    if getchar(1, {number: true}) == 0
            && !empty(getcmdcompltype())
            && !wildmenumode() && curpos == cmdline->len() + 1
            && (!cmdmode || (cmdline =~ trigger_char && cmdline !~ not_trigger_char))
        SkipCmdlineChanged()
        feedkeys("\<C-@>", "n")
    endif
enddef

def SkipCmdlineChanged(key = ''): string
    set eventignore+=CmdlineChanged
    timer_start(0, (_) => execute('set eventignore-=CmdlineChanged'))
    return key == '' ? '' : ((wildmenumode() ? "\<C-E>" : '') .. key)
enddef

cnoremap <expr> <up> SkipCmdlineChanged("\<up>")
cnoremap <expr> <down> SkipCmdlineChanged("\<down>")

augroup cmdcomplete
    au!
    autocmd CmdlineChanged : CmdComplete()
    # autocmd CmdlineEnter : feedkeys("\<C-@>", "n")
    # autocmd CmdlineEnter : set belloff+=error
    # autocmd CmdlineLeave : set belloff-=error
augroup END
