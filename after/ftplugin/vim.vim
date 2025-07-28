vim9script

b:undo_ftplugin ..= ' | setl ff< complete< omnifunc<'

setl textwidth=80

if !&readonly
    setlocal ff=unix
endif

g:vim_indent_cont = 6

setl complete^=o^7
setl omnifunc=s:VimCompletor

def Filter(haystack: list<any>, needle: string): list<any>
    if empty(needle)
        return haystack
    endif
    if &completeopt =~ 'fuzzy'
        return haystack->matchfuzzy(needle, {key: 'word', camelcase: false})
    else
        return haystack->filter((_, v) => stridx(v.word, needle) == 0)
    endif
enddef

var trigger: string = ""
def GetTrigger(line: string): list<any>
    var result = ""
    var result_len = 0

    if line =~ '->\k*$'
        result = 'function'
    elseif line =~ '\v%(^|\s+)\&\k*$'
        result = 'option'
    elseif line =~ '[\[(]\s*$'
        result = 'expression'
    elseif line =~ '[lvgsb]:\k*$'
        result = 'var'
        result_len = 2
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
    else
        result = getcompletiontype(line)
    endif
    return [result, result_len]
enddef

def VimCompletor(findstart: number, base: string): any
    if findstart > 0
        var line = getline('.')->strpart(0, col('.') - 1)
        var keyword = line->matchstr('\k\+$')
        var stx = synstack(line('.'), col('.') - 1)->map('synIDattr(v:val, "name")')->join()
        if stx =~? 'Comment' || (stx =~ 'String' && stx !~ 'vimStringInterpolationExpr')
            return -2
        endif
        var trigger_len: number = 0
        [trigger, trigger_len] = GetTrigger(line)
        if keyword->empty() && trigger->empty()
            return -2
        endif
        return line->len() - keyword->len() - trigger_len
    endif

    var funcs = getcompletion(base, 'function')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Function', dup: 0}))
    var exprs = getcompletion(base, 'expression')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Expression', dup: 0}))
    var commands = getcompletion(base, 'command')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Command', dup: 0}))
    var options = getcompletion(base, 'option')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Option', dup: 0}))
    var vars = getcompletion(base, 'var')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Variable', dup: 0}))
    var events = getcompletion(base, 'event')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Autocommand event', dup: 0}))
    var highlights = getcompletion(base, 'highlight')
        ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Highlight group', dup: 0}))

    var items = []
    if trigger == 'function'
        items = funcs
    elseif trigger == 'option'
        items = options
    elseif trigger == 'var'
        items = vars
    elseif trigger == 'expression'
        items = exprs
    elseif trigger == 'event'
        items = events
    elseif trigger == 'highlight_def_link'
        items = highlights
    elseif trigger == 'highlight_def'
        items = [
            {word: 'link', kind: 'v', menu: 'Link first highlight group to the second one.'}
        ]->Filter(base)
        + highlights
    elseif trigger == 'highlight'
        items = [
            {word: 'default', kind: 'v', menu: 'Set default highlighting.'},
            {word: 'link', kind: 'v', menu: 'Link first highlight group to the second one.'}
        ]->Filter(base)
        + highlights
    elseif trigger == 'highlight_attr'
        items = [
            'gui', 'cterm', 'guibg', 'ctermbg', 'guifg', 'ctermfg',
        ]->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Highlight group attribute', dup: 0}))
        ->Filter(base)
    elseif trigger == 'highlight_attr_noncolor'
        items = [
            'bold', 'italic', 'underline', 'NONE', 'reverse',
            'undercurl', 'underdouble', 'underdouble', 'strikethrough', 'standout'
        ]->mapnew((_, v) => ({word: v, kind: 'v', menu: 'gui= or term= value', dup: 0}))
        ->Filter(base)
    elseif trigger == 'highlight_attr_color_cterm'
        items = [
            'black', 'white', 'red', 'darkred', 'green', 'darkgreen', 'yellow', 'darkyellow',
            'blue', 'darkblue', 'magenta', 'darkmagenta', 'cyan', 'darkcyan', 'gray', 'darkgray'
        ]->mapnew((_, v) => ({word: v, kind: 'v', menu: 'cterm color', dup: 0}))
        ->Filter(base)
    elseif trigger == 'highlight_attr_color_gui'
        items = v:colornames->keys()
            ->mapnew((_, v) => ({word: v:colornames[v], kind: 'v', menu: $"Color: {v}", dup: 0}))
            ->Filter(base)
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
