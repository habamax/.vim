vim9script

# insert mode completion
set completepopup=highlight:Pmenu
set completeopt=menuone,popup,noselect,fuzzy
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,u^3
set complete+=FAbbrevCompletor^3
set complete+=FRegisterCompletor^5
set complete^=FLspCompletor^10

var instrigger = {
    vim: '\v%(\k|\k-\>|[gvbls]:)$',
    c: '\v%(\k|\k\.|\k-\>)$',
    python: '\v%(\k|\k\.)$',
    gdscript: '\v%(\$|\k|\k\.)$',
    ruby: '\v%(\k|\k\.)$',
    javascript: '\v%(\k|\k\.)$',
}
def InsComplete()
    var trigger = get(instrigger, &ft, '\S$')
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
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags

def SkipCmdlineChanged(key = ''): string
    set eventignore+=CmdlineChanged
    timer_start(0, (_) => execute('set eventignore-=CmdlineChanged'))
    return key == '' ? '' : ((wildmenumode() ? "\<C-E>" : '') .. key)
enddef

cnoremap <expr> <up> SkipCmdlineChanged("\<up>")
cnoremap <expr> <down> SkipCmdlineChanged("\<down>")
cnoremap <expr> <C-n> SkipCmdlineChanged("\<C-n>")
cnoremap <expr> <C-p> SkipCmdlineChanged("\<C-p>")

augroup cmdcomplete
    au!
    autocmd CmdlineChanged : wildtrigger()
augroup END
