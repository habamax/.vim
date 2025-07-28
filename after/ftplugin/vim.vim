vim9script

b:undo_ftplugin ..= ' | setl ff< complete< omnifunc<'

setl textwidth=80

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

setl complete^=o^7
setl omnifunc=s:VimCompletor

var trigger: string = ""
def GetTrigger(line: string): string
    var result = ""
    if line =~ '->\k*$' || line =~ '\vcall\s+\k*$'
        result = 'func'
    elseif line =~ '&\k*$' || line =~ '\vset%(\s+\k*)*$'
        result = 'option'
    elseif line =~ '\vecho%[msg]\s+\k*$'
        result = 'expr'
    elseif line =~ '\vau%[tocmd]\s+\k*$'
        result = 'event'
    elseif line =~ '\vhi%[ghlight]!?\s+%(def%[ault]\s+)?link\s+(\k+\s+)?\k*$'
        result = 'highlight_def_link'
    elseif line =~ '\vhi%[ghlight]!?\s+def%[ault]\s+\k*$'
        result = 'highlight_def'
    elseif line =~ '\vhi%[ghlight]!?\s+%(def%[ault]\s+)?\k+%(\s+\k+\=%(\k+,?)+)*%(\s+%(cterm|gui)\=)%(\k+,)*\k*$'
        result = 'highlight_attr_noncolor'
    elseif line =~ '\vhi%[ghlight]!?\s+%(def%[ault]\s+)?\k+%(\s+\k+\=%(\k+,?)+)*%(\s+cterm[fb]g\=)\k*$'
        result = 'highlight_attr_color_cterm'
    elseif line =~ '\vhi%[ghlight]!?\s+%(def%[ault]\s+)?\k+%(\s+\k+\=%(\k+,?)+)*%(\s+gui[fb]g\=)\k*$'
        result = 'highlight_attr_color_gui'
    elseif line =~ '\vhi%[ghlight]!?\s+%(def%[ault]\s+)?\k+%(\s+\k+\=%(\k+,?)+)*\s+\k*$'
        result = 'highlight_attr'
    elseif line =~ '\vhi%[ghlight]!?\s+\k*$'
        result = 'highlight'
    endif
    return result
enddef

def VimCompletor(findstart: number, base: string): any
    if findstart > 0
        var line = getline('.')->strpart(0, col('.') - 1)
        var keyword = line->matchstr('\k\+$')
        var stx = synstack(line('.'), col('.') - 1)->map('synIDattr(v:val, "name")')->join()
        if stx =~? 'Comment' || (stx =~ 'String' && stx !~ 'vimStringInterpolationExpr')
            return -2
        endif
        trigger = GetTrigger(line)
        if keyword->empty() && trigger->empty()
            return -2
        endif
        return line->len() - keyword->len()
    endif

    var funcs = getcompletion(base, 'function')
        ->mapnew((_, v) => ({word: v, kind: 'f', menu: 'Vim function', dup: 0}))
    var exprs = getcompletion(base, 'expression')
        ->mapnew((_, v) => ({word: v, kind: 'e', menu: 'Vim expression', dup: 0}))
    var commands = getcompletion(base, 'command')
        ->mapnew((_, v) => ({word: v, kind: 'c', menu: 'Vim command', dup: 0}))
    var options = getcompletion(base, 'option')
        ->mapnew((_, v) => ({word: v, kind: 'o', menu: 'Vim option', dup: 0}))
    var events = getcompletion(base, 'event')
        ->mapnew((_, v) => ({word: v, kind: 'a', menu: 'Vim autocommand event', dup: 0}))
    var highlights = getcompletion(base, 'highlight')
        ->mapnew((_, v) => ({word: v, kind: 'a', menu: 'Vim highlight group', dup: 0}))

    # echow "trigger:" trigger "base:" base
    var items = []
    if trigger == 'func'
        items = funcs
    elseif trigger == 'option'
        items = options
    elseif trigger == 'expr'
        items = exprs
    elseif trigger == 'event'
        items = events
    elseif trigger == 'highlight_def_link'
        items = highlights
    elseif trigger == 'highlight_def'
        items = ['link'] + highlights
    elseif trigger == 'highlight'
        items = ['default', 'link'] + highlights
    elseif trigger == 'highlight_attr'
        items = ['gui', 'cterm', 'guibg', 'ctermbg', 'guifg', 'ctermfg']
    elseif trigger == 'highlight_attr_noncolor'
        items = ['bold', 'italic', 'underline', 'NONE']
    elseif trigger == 'highlight_attr_color_cterm'
        items = [
            'black', 'white', 'red', 'darkred', 'green', 'darkgreen', 'yellow', 'darkyellow',
            'blue', 'darkblue', 'magenta', 'darkmagenta', 'cyan', 'darkcyan', 'gray', 'darkgray'
        ]
    elseif trigger == 'highlight_attr_color_gui'
        items = v:colornames->keys()
            ->mapnew((_, v) => ({word: v:colornames[v], kind: '#', menu: v, dup: 0}))
    elseif !empty(base)
        items = commands->extend(funcs)
    endif

    return items->empty() ? v:none : items
enddef

import autoload 'popup.vim'
def Things()
    var things = []
    var commentchars = split(&cms, "%s")[0]
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line =~ '\(^\|\s\)def \([g]:\)\?\k\+('
        || line =~ '\(^\|\s\)fu\%[nction]!\?\s\+\([sgl]:\)\?\k\+('
        || line =~ '^\s*com\%[mand]!\?\s\+\S\+'
        || line =~ '^\s*aug\%[roup]\s\+\S\+' && line !~ '\c^\s*aug\%[roup] end\s*$'
            if line =~ '^\s*com\%[mand]!\?\s\+\S\+'
                line = line->substitute(' -\(range\|count\|nargs\)\(=.\)\?', '', 'g')
                line = line->substitute(' -\(bang\|buffer\)', '', '')
                line = line->substitute(' -complete=\S\+', '', '')
                line = line->substitute('^\s*com\%[mand]!\?\s\+\S\+\zs.*', '', '')
                line = line->substitute('^\s*com\%[mand]!\?\s\+', '', '')
            endif
            things->add({text: line, posttext: $' ({nr})', linenr: nr})
        endif
        if line =~ '{\{3}\s*$'
            line = matchstr(line, '^\s*' .. commentchars .. '\s*\zs.\{-}\ze\s*{\{3}\s*$')
            things->add({text: line, posttext: $' ({nr})', linenr: nr})
        endif
    endfor
    popup.Select("Vim Things", things,
        (res, key) => {
            exe $":{res.linenr}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, $"syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, $"syn match PopupSelectFuncName '\\k\\+\\ze('")
            hi def link PopupSelectLineNr Comment
            hi def link PopupSelectFuncName Function
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>

nnoremap <buffer> <F5> :source<CR>

iab <buffer> v9 vim9script<C-R>=misc#Eatchar('\s')<CR>

def SentenceForward()
    var rx = '\v<((else(if)?)|(end(if|def|for|while|func|try)))>'
    var res = search(rx, 'e')
    var stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    while res != 0 && (!empty(stx) && stx[-1] =~ 'Comment\|String')
        res = search(rx, 'e')
        stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endwhile
enddef

def SentenceBackward()
    var rxDef = '<((export\s+)?def\s+\k+\s*\()'
    var rxFunc = '(<(^\s*func\s+\k+\s*\())'
    var rxRest = '(<(try|finally|catch|if|else|elseif|for|while)>)'
    var rx = $'\v{rxDef}|{rxFunc}|{rxRest}'
    var res = search(rx, 'b')
    var stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    while res != 0 && (!empty(stx) && stx[-1] =~ 'Comment\|String')
        res = search(rx, 'b')
        stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endwhile
enddef

nnoremap <buffer> ) <scriptcmd>SentenceForward()<cr>
xnoremap <buffer> ) <scriptcmd>SentenceForward()<cr>
onoremap <buffer> ) v<scriptcmd>SentenceForward()<cr>
nnoremap <buffer> ( <scriptcmd>SentenceBackward()<cr>
xnoremap <buffer> ( <scriptcmd>SentenceBackward()<cr>
onoremap <buffer> ( v<scriptcmd>SentenceBackward()<cr>
