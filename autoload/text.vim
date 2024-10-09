vim9script

# Name: autoload/text.vim
# Author: Maxim Kim <habamax@gmail.com>
# Desc: Text manipulation functions.

# Fix text:
# * replace non-breaking spaces with spaces
# * replace multiple spaces with a single space (preserving indent)
# * remove spaces between closed braces: ) ) -> ))
# * remove space before closed brace: word ) -> word)
# * remove space after opened brace: ( word -> (word
# * remove space at the end of line
# Usage:
# command! -range FixSpaces call text#fix_spaces(<line1>,<line2>)
export def FixSpaces(line1: number, line2: number)
    var view = winsaveview()
    defer winrestview(view)
    # replace non-breaking space to space first
    exe printf('silent :%d,%ds/\%%xA0/ /ge', line1, line2)
    # replace multiple spaces to a single space (preserving indent)
    exe printf('silent :%d,%ds/\S\+\zs\(\s\|\%%xa0\)\+/ /ge', line1, line2)
    # remove spaces between closed braces: ) ) -> ))
    exe printf('silent :%d,%ds/)\s\+)\@=/)/ge', line1, line2)
    # remove spaces between opened braces: ( ( -> ((
    exe printf('silent :%d,%ds/(\s\+(\@=/(/ge', line1, line2)
    # remove space before closed brace: word ) -> word)
    exe printf('silent :%d,%ds/\s)/)/ge', line1, line2)
    # remove space after opened brace: ( word -> (word
    exe printf('silent :%d,%ds/(\s/(/ge', line1, line2)
    # remove space at the end of line
    exe printf('silent :%d,%ds/\s*$//ge', line1, line2)
enddef

# Underline current line.
# example mappings:
# nnoremap <silent> <space>= :call text#Underline('=')<CR>
# nnoremap <silent> <space>- :call text#Underline('-')<CR>
# nnoremap <silent> <space>~ :call text#Underline('~')<CR>
# nnoremap <silent> <space>^ :call text#Underline('^')<CR>
# nnoremap <silent> <space>+ :call text#Underline('+')<CR>
export def Underline(char: string)
    var nextnr = line('.') + 1
    var line = matchlist(getline('.'), '^\(\s*\)\(.*\)$')
    if empty(line[2]) | return | endif
    var underline = line[1] .. repeat(char, strchars(line[2]))
    if getline(nextnr) =~ '^\s*' .. escape(char, '*\~^.') .. '\+$'
        setline(nextnr, underline)
    else
        append('.', underline)
    endif
enddef


# Dates (text object and stuff)
var mons_en = ['Jan', 'Feb', 'Mar', 'Apr',
               'May', 'Jun', 'Jul', 'Aug',
               'Sep', 'Oct', 'Nov', 'Dec']
var months_en = ['January',   'February', 'March',    'April',
                 'May',       'June',     'July',     'August',
                 'September', 'October',  'November', 'December']
var months_ru = ['января',   'февраля', 'марта',  'апреля',
                 'мая',      'июня',    'июля',   'августа',
                 'сентября', 'октября', 'ноября', 'декабря']

var months = extend(months_en, months_ru)
months = extend(months, mons_en)
g:months = copy(months)

# * ISO-8601 2020-03-21
# * RU 21 марта 2020
# * EN 10 December 2012
# * EN December 10, 2012
# * EN December 10 2012
# * EN 10 Dec 2012
# * EN Dec 10, 2012
# * EN Dec 10 2012
# Usage:
# xnoremap <silent> id :<C-u>call text#ObjDate(1)<CR>
# onoremap id :<C-u>normal vid<CR>
# xnoremap <silent> ad :<C-u>call text#ObjDate(0)<CR>
# onoremap ad :<C-u>normal vad<CR>
export def ObjDate(inner: bool)
    var view = winsaveview()
    var cword = expand("<cword>")
    if  cword =~ '\d\{4}'
        var rx = '\%(\D\d\{1,2}\s\+\%(' .. join(months, '\|') .. '\)\)'
        rx ..= '\|'
        rx ..= '\%(\s*\%(' .. join(months, '\|') .. '\)\s\+\d\{1,2},\?\)'
        if !search(rx, 'bcW', line('.'))
            search('\s*\D', 'bcW', line('.'))
        endif
    elseif cword =~ join(months, '\|')
        search('^\|\D\ze\d\{1,2}\s\+', 'bceW')
    elseif cword =~ '\d\{1,2}'
        if !search('^\|\S\ze\%(' .. join(months, '\|') .. '\)\s\+\d\{1,2}', 'bceW')
            search('^\|[^0-9\-]', 'becW')
        endif
    endif

    var rxdate = '\%(\d\{4}-\d\{2}-\d\{2}\)'
    rxdate ..= '\|'
    rxdate ..= '\%(\d\{1,2}\s\+\%(' .. join(months, '\|') .. '\)\s\+\d\{4}\)'
    rxdate ..= '\|'
    rxdate ..= '\%(\%(' .. join(months, '\|') .. '\)\s\+\d\{1,2},\?\s\+\d\{4}\)'
    if !inner
        rxdate = '\s*\%(' .. rxdate .. '\)\s*'
    endif

    if search(rxdate, 'cW') > 0
        normal v
        search(rxdate, 'ecW')
        return
    endif
    winrestview(view)
enddef

export def ObjDateRu()
    var [year, month, day] = split(strftime("%Y-%m-%d"), '-')
    return printf("%d %s %s", day, months_ru[month-1], year)
enddef

# number text object
export def ObjNumber()
    var rx_num = '\d\+\(\.\d\+\)*'
    if search(rx_num, 'ceW') > 0
        normal! v
        search(rx_num, 'bcW')
    endif
enddef

# Line text object
export def ObjLine(inner: bool)
    if inner
        normal! g_v^
    else
        normal! $v0
    endif
enddef

# Indent text object
# Usage:
# import autoload 'text.vim'
# onoremap <silent>ii <scriptcmd>text.ObjIndent(v:true)<CR>
# onoremap <silent>ai <scriptcmd>text.ObjIndent(v:false)<CR>
# xnoremap <silent>ii <esc><scriptcmd>text.ObjIndent(v:true)<CR>
# xnoremap <silent>ai <esc><scriptcmd>text.ObjIndent(v:false)<CR>
export def ObjIndent(inner: bool)
    var ln_start: number
    var ln_end: number
    if getline('.') =~ '^\s*$'
        ln_start = prevnonblank('.') ?? 1
    else
        ln_start = line('.')
    endif

    var indent = indent(ln_start)

    while indent == 0 && ln_start < line('$')
        ln_start = nextnonblank(ln_start + 1) ?? line('$')
        indent = indent(ln_start)
    endwhile

    if indent == 0
        return
    endif

    ln_end = ln_start

    while ln_start > 0 && indent(ln_start) >= indent
        ln_start = prevnonblank(ln_start - 1)
    endwhile

    while ln_end <= line('$') && indent(ln_end) >= indent
        ln_end = nextnonblank(ln_end + 1) ?? line('$') + 1
    endwhile

    if inner
        ln_start = nextnonblank(ln_start + 1) ?? line('$') + 1
        ln_end = prevnonblank(ln_end - 1)
    else
        ln_start += 1
        ln_end -= 1
    endif

    if ln_end < ln_start
        ln_end = ln_start
    endif

    exe ":" ln_end
    normal! V
    exe ":" ln_start
enddef

# Comment text object
# Usage:
# import autoload 'text.vim'
# onoremap <silent>ic <scriptcmd>text.ObjComment(v:true)<CR>
# onoremap <silent>ac <scriptcmd>text.ObjComment(v:false)<CR>
# xnoremap <silent>ic <esc><scriptcmd>text.ObjComment(v:true)<CR>
# xnoremap <silent>ac <esc><scriptcmd>text.ObjComment(v:false)<CR>
export def ObjComment(inner: bool)
    def IsComment(): bool
        var stx = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')->join()
        if stx =~ 'Comment'
            return true
        else
            return false
        endif
    enddef

    var pos_init = getcurpos()

    # If not in comment, search next one,
    if !IsComment()
        if search('\S\+', 'W', line(".") + 100, 100, () => !IsComment()) <= 0
            return
        endif
    endif

    # Search for the beginning of the comment block
    if IsComment()
        if search('\v(\S+)|$', 'bW', 0, 200, IsComment) > 0
            search('\v(\S+)|$', 'W', 0, 200, () => !IsComment())
        else
            cursor(1, 1)
            search('\S\+', 'cW', 0, 200)
        endif
    endif

    var pos_start = getcurpos()

    if !inner
        if search('\s*', 'bW', line('.'), 200) > 0
            pos_start = getcurpos()
        endif
    endif

    # Search for the comment end.
    if pos_init[1] > pos_start[1]
        cursor(pos_init[1], pos_init[2])
    endif
    if search('\v(\S+)|$', 'W', 0, 200, IsComment) > 0
        search('\S', 'beW', 0, 200, () => !IsComment())
    else
        if search('\%$', 'W', 0, 200) > 0
            search('\ze\S', 'beW', 0, 200, () => !IsComment())
        endif
    endif

    var pos_end = getcurpos()

    if !inner
        var spaces = matchstr(getline(pos_end[1]), '\%>.c\s*')
        pos_end[2] += spaces->len()
        if getline(pos_end[1])[pos_end[2] : ] =~ '^\s*$'
            && (pos_start[2] == 1 || getline(pos_start[1])[ : pos_start[2]] =~ '^\s*$')
            if search('\v\s*\_$(\s*\n)+', 'eW', 0, 200) > 0
                pos_end = getcurpos()
            endif
        endif
    endif

    if (pos_end[2] == (getline(pos_end[1])->len() ?? 1)) && pos_start[2] == 1
        cursor(pos_end[1], 1)
        normal! V
        cursor(pos_start[1], 1)
    else
        cursor(pos_end[1], pos_end[2])
        normal! v
        cursor(pos_start[1], pos_start[2])
    endif
enddef

# 26 simple text objects
# ----------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
# Usage:
# for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
#     execute $"xnoremap <silent> i{char} <esc><scriptcmd>text.Obj('{char}', 1)<CR>"
#     execute $"xnoremap <silent> a{char} <esc><scriptcmd>text.Obj('{char}', 0)<CR>"
#     execute $"onoremap <silent> i{char} :normal vi{char}<CR>"
#     execute $"onoremap <silent> a{char} :normal va{char}<CR>"
# endfor
export def Obj(char: string, inner: bool)
    var lnum = line('.')
    var echar = escape(char, '.*\')
    if (search('^\|' .. echar, 'cnbW', lnum) > 0 && search(echar, 'W', lnum) > 0)
        || (search(echar, 'nbW', lnum) > 0 && search(echar .. '\|$', 'cW', lnum) > 0)
        if inner
            search('[^' .. escape(char, '\') .. ']', 'cbW', lnum)
        endif
        normal! v
        search('^\|' .. echar, 'bW', lnum)
        if inner
            search('[^' .. escape(char, '\') .. ']', 'cW', lnum)
        endif
        return
    endif
enddef

# Toggle current word
# nnoremap <silent> <BS> <cmd>call text#Toggle()<CR>
export def Toggle()
    var toggles = {
        true: 'false', false: 'true', True: 'False', False: 'True', TRUE: 'FALSE', FALSE: 'TRUE',
        yes: 'no', no: 'yes', Yes: 'No', No: 'Yes', YES: 'NO', NO: 'YES',
        on: 'off', off: 'on', On: 'Off', Off: 'On', ON: 'OFF', OFF: 'ON',
        open: 'close', close: 'open', Open: 'Close', Close: 'Open',
        dark: 'light', light: 'dark',
        width: 'height', height: 'width',
        first: 'last', last: 'first',
        top: 'right', right: 'bottom', bottom: 'left', left: 'center', center: 'top',
    }
    var word = expand("<cword>")
    if toggles->has_key(word)
        execute 'normal! "_ciw' .. toggles[word]
    endif
enddef
