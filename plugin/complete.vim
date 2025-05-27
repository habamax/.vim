vim9script

# insert mode completion
set completepopup=highlight:Pmenu
set completeopt=menuone,popup,noselect,fuzzy
# set completeopt=menuone,popup,noselect,nearest
set infercase
set complete=o^10,.^10,w^5,b^5,u^5,t^5
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
        if m->len() > 2 && m[1]->stridx(base) == 0
            items->add({ word: m[1], kind: "ab", info: m[2], dup: 1 })
        endif
    endfor
    return items->empty() ? v:none :
        items
        ->sort((v1, v2) => v1.word < v2.word ? -1 : v1.word ==# v2.word ? 0 : 1)
enddef

def InsComplete()
    if getcharstr(1) == '' && getline('.')->strpart(0, col('.') - 1) =~ '\v%(\k|\k\.|\k-\>)$'
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
# have a close look at this:
# https://github.com/vim/vim/pull/16759

set wildmode=noselect:lastused,full
set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildcharm=<C-@>
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags

def CmdComplete(cur_cmdline: string, timer: number)
    var [cmdline, curpos] = [getcmdline(), getcmdpos()]
    if cur_cmdline ==# cmdline # Avoid completing each char of keymaps and pasted text
      && !pumvisible() && curpos == cmdline->len() + 1
      && cmdline =~ '\%(\w\|[*/:.-]\)$' && cmdline !~ '^\d\+$'  # Reduce noise
        feedkeys("\<C-@>", "ti")
        set eventignore+=CmdlineChanged  # Suppress redundant completion attempts
        timer_start(0, (_) => {
            getcmdline()->substitute('\%x00', '', 'g')->setcmdline()  # Remove <C-@> if no completion items exist
            set eventignore-=CmdlineChanged
        })
    endif
enddef

def MuteEventAndSend(key: string): string
    set ei+=CmdlineChanged
    timer_start(0, (_) => execute('set ei-=CmdlineChanged'))
    return (pumvisible() ? "\<c-e>" : "") .. key
enddef

cnoremap <expr> <up> MuteEventAndSend("\<up>")
cnoremap <expr> <down> MuteEventAndSend("\<down>")


augroup cmdcomplete
    au!
    autocmd CmdlineChanged : timer_start(0, function(CmdComplete, [getcmdline()]))
    autocmd CmdlineEnter : set bo+=error
    autocmd CmdlineLeave : set bo-=error
augroup END
