vim9script

# Name: autoload/text.vim
# Author: Maxim Kim <habamax@gmail.com>
# Desc: Text manipulation functions.

# Fix text:
# * replace non-breaking spaces to spaces
# * replace multiple spaces to a single space (preserving indent)
# * remove spaces between closed braces: ) ) -> ))
# * remove space before closed brace: word ) -> word)
# * remove space after opened brace: ( word -> (word
# * remove space at the end of line
# Usage:
# command! -range FixSpaces call text#fix_spaces(<line1>,<line2>)
def text#FixSpaces(line1: number, line2: number)
    var view = winsaveview()
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
    winrestview(view)
enddef


# Underline current line with a chars
# example mappings:
# nnoremap <silent> <space>= :call text#Underline('=')<CR>
# nnoremap <silent> <space>- :call text#Underline('-')<CR>
# nnoremap <silent> <space>~ :call text#Underline('~')<CR>
# nnoremap <silent> <space>^ :call text#Underline('^')<CR>
# nnoremap <silent> <space>+ :call text#Underline('+')<CR>
def text#Underline(char: string)
    var nextnr = line('.') + 1
    var line = matchlist(getline('.'), '^\(\s*\)\(.*\)$')
    if empty(line[2]) | return | endif
    var underline = line[1] .. repeat(char, strchars(line[2]))
    if getline(nextnr) =~ '^\s*' .. escape(char, '*\~^') .. '\+$'
        setline(nextnr, underline)
    else
        append('.', underline)
    endif
enddef


# Dates (text object and stuff)
var s:mons_en = ['Jan', 'Feb', 'Mar', 'Apr',
                 'May', 'Jun', 'Jul', 'Aug',
                 'Sep', 'Oct', 'Nov', 'Dec']
var s:months_en = ['January', 'February', 'March', 'April',
                   'May', 'June', 'July', 'August',
                   'September', 'October', 'November', 'December']
var s:months_ru = ['января', 'февраля', 'марта', 'апреля',
                   'мая', 'июня', 'июля', 'августа',
                   'сентября', 'октября', 'ноября', 'декабря']

var s:months = extend(s:months_en, s:months_ru)
s:months = extend(s:months, s:mons_en)
g:months = copy(s:months)

# * ISO-8601 2020-03-21
# * RU 21 марта 2020
# * EN 10 December 2012
# * EN December 10, 2012
# * EN 10 Dec 2012
# * EN Dec 10, 2012
# Usage:
# xnoremap <silent> id :<C-u>call text#ObjDate(1)<CR>
# onoremap id :<C-u>normal vid<CR>
# xnoremap <silent> ad :<C-u>call text#ObjDate(0)<CR>
# onoremap ad :<C-u>normal vad<CR>
def text#ObjDate(inner: bool)
    var view = winsaveview()
    var cword = expand("<cword>")
    if  cword =~ '\d\{4}'
        # var rx = '^\|'
        var rx = '\%(\D\d\{1,2}\s\+\%(' .. join(s:months, '\|') .. '\)\)'
        rx ..= '\|'
        rx ..= '\%(\s*\%(' .. join(s:months, '\|') .. '\)\s\+\d\{1,2},\)'
        if !search(rx, 'bcW', line('.'))
            search('\s*\D', 'bcW', line('.'))
        endif
    elseif cword =~ join(s:months, '\|')
        search('^\|\D\ze\d\{1,2}\s\+', 'bceW')
    elseif cword =~ '\d\{1,2}'
        if !search('^\|\S\ze\%(' .. join(s:months, '\|') .. '\)\s\+\d\{1,2}', 'bceW')
            search('^\|[^0-9\-]', 'becW')
        endif
    endif

    var rxdate = '\%(\d\{4}-\d\{2}-\d\{2}\)'
    rxdate ..= '\|'
    rxdate ..= '\%(\d\{1,2}\s\+\%(' .. join(s:months, '\|') .. '\)\s\+\d\{4}\)'
    rxdate ..= '\|'
    rxdate ..= '\%(\%(' .. join(s:months, '\|') .. '\)\s\+\d\{1,2},\s\+\d\{4}\)'
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


def text#ObjDateRu()
    var [year, month, day] = split(strftime("%Y-%m-%d"), '-')
    return printf("%d %s %s", day, s:months_ru[month-1], year)
enddef


# number text object
def text#ObjNumber()
    var rx_num = '\d\+\(\.\d\+\)*'
    if search(rx_num, 'ceW') > 0
        normal! v
        search(rx_num, 'bcW')
    endif
enddef


# Line text object
def text#ObjLine(inner: bool)
    if inner
        normal! g_v^
    else
        normal! $v0
    endif
enddef


# Indent text object
# Useful for python-like indentation based programming lanugages
# Usage:
# onoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
# onoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
# xnoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
# xnoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
def text#ObjIndent(inner: bool)
    var ln_start: number
    var ln_end: number
    if getline('.') =~ '^\s*$'
        ln_start = s:detect_nearest_line()
        ln_end = ln_start
    else
        ln_start = line('.')
        ln_end = ln_start
    endif

    var indent = indent(ln_start)
    if indent > 0
        while ln_start > 0 && indent(ln_start) >= indent 
            ln_start = prevnonblank(ln_start - 1)
        endwhile

        while ln_end <= line('$') && indent(ln_end) >= indent
            ln_end = s:nextnonblank(ln_end + 1)
        endwhile
    else
        while ln_start > 0 && indent(ln_start) == 0 && getline(ln_start) !~ '^\s*$'
            ln_start -= 1
        endwhile
        while ln_start > 0 && indent(ln_start) > 0
            ln_start = prevnonblank(ln_start - 1)
        endwhile
        while ln_start > 0 && indent(ln_start) == 0 && getline(ln_start) !~ '^\s*$'
            ln_start -= 1
        endwhile

        while ln_end <= line('$') && indent(ln_end) == 0 && getline(ln_end) !~ '^\s*$'
            ln_end += 1
        endwhile
        while ln_end <= line('$') && indent(ln_end) > 0
            ln_end = s:nextnonblank(ln_end + 1)
        endwhile
    endif

    if inner || indent == 0
        ln_start = s:nextnonblank(ln_start + 1)
    endif

    if inner
        ln_end = prevnonblank(ln_end - 1)
    else
        ln_end = ln_end - 1
    endif

    if ln_end < ln_start
        ln_end = ln_start
    endif

    exe ":" ln_end
    normal! V
    exe ":" ln_start
enddef


def s:nextnonblank(lnum: number): number
    var res = nextnonblank(lnum)
    if res == 0
        res = line('$') + 1
    endif
    return res
enddef


def s:detect_nearest_line(): number
    var lnum = line('.')
    var nline = s:nextnonblank(lnum)
    var pline = prevnonblank(lnum)
    if abs(nline - lnum) > abs(pline - lnum) || getline(nline) =~ '^\s*$'
        return pline
    else
        return nline
    endif
enddef


# 26 simple text objects
# ----------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
# Usage:
# for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
#     execute 'xnoremap <silent> i' .. char .. ' :<C-u>call text#Obj("' .. char .. '", 1)<CR>'
#     execute 'xnoremap <silent> a' .. char .. ' :<C-u>call text#Obj("' .. char .. '", 0)<CR>'
#     execute 'onoremap <silent> i' .. char .. ' :normal vi' .. char .. '<CR>'
#     execute 'onoremap <silent> a' .. char .. ' :normal va' .. char .. '<CR>'
# endfor
def text#Obj(char: string, inner: bool)
    var lnum = line('.')
    var echar = escape(char, '.*')
    if (search('^\|' .. echar, 'cnbW', lnum) > 0 && search(echar, 'W', lnum) > 0)
        || (search(echar, 'nbW', lnum) > 0 && search(echar .. '\|$', 'cW', lnum) > 0)
        if inner
            search('[^' .. char .. ']', 'cbW', lnum)
        endif
        normal! v
        search('^\|' .. echar, 'bW', lnum)
        if inner
            search('[^' .. char .. ']', 'cW', lnum)
        endif
        return
    endif
enddef


# Toggle current word
# nnoremap <expr> <BS> text#Toggle()
def text#Toggle(): string
    var toggles = {
        true: 'false', false: 'true', True: 'False', False: 'True', TRUE: 'FALSE', FALSE: 'TRUE',
        yes: 'no', no: 'yes', Yes: 'No', No: 'Yes', YES: 'NO', NO: 'YES',
        open: 'close', close: 'open', Open: 'Close', Close: 'Open',
        on: 'off', off: 'on', On: 'Off', Off: 'On',
        dark: 'light', light: 'dark',
        width: 'height', height: 'width',
        first: 'last', last: 'first',
        top: 'right', right: 'bottom', bottom: 'left', left: 'center', center: 'top',
    }
    var word = expand("<cword>")
    if toggles->has_key(word)
        return '"_ciw' .. toggles[word] .. "\<esc>"
    endif
    return ''
enddef

