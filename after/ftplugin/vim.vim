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
var prefix: string = ""

def GetTrigger(line: string): list<any>
    var result = ""
    var result_len = 0

    if line =~ '->\k*$'
        result = 'function'
    elseif line =~ '\v%(^|\s+)\&\k*$'
        result = 'option'
    elseif line =~ '[lvgsb]:\k*$'
        result = 'var'
        result_len = 2
    else
        result = getcompletiontype(line) ?? 'cmdline'
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
        prefix = line
        return line->len() - keyword->len() - trigger_len
    endif


    var items = []
    if trigger == 'function'
        items = getcompletion(base, 'function')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Function', dup: 0}))
    elseif trigger == 'option'
        items = getcompletion(base, 'option')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Option', dup: 0}))
    elseif trigger == 'var'
        items = getcompletion(base, 'var')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Variable', dup: 0}))
    elseif trigger == 'expression'
        items = getcompletion(base, 'expression')
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Expression', dup: 0}))
    elseif trigger == 'command'
        items = getcompletion(base, 'command')->extend(getcompletion(base, 'function'))
            ->mapnew((_, v) => ({word: v, kind: 'v', menu: 'Function/Command', dup: 0}))
    else
        items = getcompletion(prefix, 'cmdline')
            ->mapnew((_, v) => ({word: v->matchstr('\k\+'), kind: 'v', dup: 0}))
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
