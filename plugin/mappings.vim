vim9script


# source vimscript (operator)
def SourceVim(...args: list<any>): any
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif
    if getline(1) =~ '^vim9script$'
        vim9cmd :'[,']source
    else
        :'[,']source
    endif
    return ''
enddef
nnoremap <silent> <expr> <space>v SourceVim()
xnoremap <silent> <expr> <space>v SourceVim()
nnoremap <silent> <expr> <space>vv SourceVim() .. '_'


# fuzzy
import autoload 'fuzzy.vim'
nnoremap <space>e <scriptcmd>fuzzy.File()<CR>
nnoremap <space>fe <scriptcmd>fuzzy.FileTree()<CR>
nnoremap <space>ge <scriptcmd>fuzzy.GitFile()<CR>
nnoremap <space>b <scriptcmd>fuzzy.Buffer()<CR>
nnoremap <space>h <scriptcmd>fuzzy.Help()<CR>
nnoremap <space>fm <scriptcmd>fuzzy.MRU()<CR>
nnoremap <space>fv <scriptcmd>fuzzy.GitFile(fnamemodify($MYVIMRC, ":p:h"))<CR>
nnoremap <space>fd <scriptcmd>fuzzy.GitFile($DOCS ?? '~/docs')<CR>
nnoremap <space>fD <scriptcmd>fuzzy.File($DOCS ?? '~/docs')<CR>
nnoremap <space>fc <scriptcmd>fuzzy.Colorscheme()<CR>
nnoremap <space>fi <scriptcmd>fuzzy.Template()<CR>
nnoremap <space>fs <scriptcmd>fuzzy.Session()<CR>
nnoremap <space>fb <scriptcmd>fuzzy.Bookmark()<CR>
nnoremap <space>ft <scriptcmd>fuzzy.Filetype()<CR>
nnoremap <space>fh <scriptcmd>fuzzy.Highlight()<CR>
nnoremap <space>fR <scriptcmd>fuzzy.File($VIMRUNTIME)<CR>
nnoremap <space>; <scriptcmd>fuzzy.CmdHistory()<CR>
nnoremap <space>fp <scriptcmd>fuzzy.Project()<CR>


# enhance search, only if wildcharm is set to <c-z>
if &wildcharm == 26
    cnoremap <expr> <tab>   get({'/': "\<c-g>", '?': "\<c-t>"}, getcmdtype()) ?? "<c-z>"
    cnoremap <expr> <s-tab> get({'/': "\<c-t>", '?': "\<c-g>"}, getcmdtype()) ?? "<s-tab>"
endif

# search&replace
nnoremap <space>% :<C-U>%s/\<<C-r>=expand("<cword>")<CR>\>/
xnoremap <space>% y:%s/<C-r>=escape(@", '^~$\&*.[]')<CR>//g<left><left>
nnoremap <space>/ /<C-r>=expand("<cword>")<CR>
xnoremap <space>/ y/<C-R>"
xnoremap * y/<C-R>"<CR>

# toggles
nnoremap <space>tw <cmd>set wrap! wrap?<CR>
nnoremap <space>ts <cmd>set spell! spell?<CR>
nnoremap <space>td <cmd>exe (&diff ? ':diffoff' : ':diffthis')<CR>
nnoremap <space>tv <scriptcmd>&ve = (&ve == "block" ? "all" : "block")<CR><cmd>set ve<CR>
nnoremap <space>tt <scriptcmd>&bg = (&bg == "light" ? "dark" : "light")<CR>
nnoremap <space>tn <cmd>set nu! rnu! cul!<CR>

# move lines
xnoremap <tab> :sil! m '>+1<CR>gv
xnoremap <s-tab> :sil! m '<-2<CR>gv

# toggle colorcolumn at cursor position
# set vartabstop accordingly
def ToggleCC(all: bool = false)
    if all
        b:cc = &cc ?? get(b:, "cc", "80")
        &cc = empty(&cc) ? b:cc : ""
    else
        var col = virtcol('.')
        var cc = split(&cc, ",")->map((_, v) => str2nr(v))
        if index(cc, col) == -1
            exe "set cc=" .. cc->add(col)->sort('f')->map((_, v) => printf("%s", v))->join(',')
        else
            exe $"set cc-={col}"
        endif
    endif
    if !&expandtab | return | endif
    var cc = split(&cc, ",")->map((_, v) => str2nr(v))
    if len(cc) > 1 || len(cc) == 1 && cc[0] < 60
        setl vsts&
        var shift = 1
        for v in cc
            if v == 1 | continue | endif
            exe $"set vsts+={v - shift}"
            shift = v
        endfor
        exe $"setl vsts+={&sw}"
    else
        setl vsts&
    endif
enddef
nnoremap <silent> <space>tc <ScriptCmd>ToggleCC()<CR>
nnoremap <silent> <space>tC <ScriptCmd>ToggleCC(true)<CR>

nnoremap <silent> <space><cr> <scriptcmd>text.Toggle()<CR>

# print maybe-function name
nnoremap [f <cmd>echo getline(search('^[[:alpha:]$_]', 'bcnW'))<CR>

# windows
def ResizeWin(width: number, height: number)
    var w = max([width, winwidth(0)])
    var h = max([height, winheight(0)])
    execute 'vertical resize' w
    execute 'resize' h
    try
        setlocal winfixwidth winfixheight
        wincmd =
    finally
        setlocal nowinfixwidth nowinfixheight
        normal! ze
    endtry
enddef
noremap <silent> <C-w>m <ScriptCmd>ResizeWin(v:count * 10 + 90, 25)<CR>
map <C-w><C-m> <C-w>m
tnoremap <silent> <C-w>m <ScriptCmd>ResizeWin(v:count * 10 + 90, 25)<CR>
tmap <C-w><C-m> <C-w>m

# better PgUp/PgDn
def MapL()
    var line = line('.')
    normal! L
    if line == line('$')
        normal! zb
    elseif line == line('.')
        normal! zt
    endif
enddef
def MapH()
    var line = line('.')
    normal! H
    if line == line('.')
        normal! zb
    endif
enddef

noremap L <ScriptCmd>MapL()<CR>
noremap H <ScriptCmd>MapH()<CR>


import autoload 'text.vim'

# simple text objects
# -------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
    execute 'xnoremap <silent> i' .. char .. ' <esc><scriptcmd>text.Obj("' .. char .. '", 1)<CR>'
    execute 'xnoremap <silent> a' .. char .. ' <esc><scriptcmd>text.Obj("' .. char .. '", 0)<CR>'
    execute 'onoremap <silent> i' .. char .. ' :normal vi' .. char .. '<CR>'
    execute 'onoremap <silent> a' .. char .. ' :normal va' .. char .. '<CR>'
endfor

# indent text object
onoremap <silent>ii <scriptcmd>text.ObjIndent(v:true)<CR>
onoremap <silent>ai <scriptcmd>text.ObjIndent(v:false)<CR>
xnoremap <silent>ii <esc><scriptcmd>text.ObjIndent(v:true)<CR>
xnoremap <silent>ai <esc><scriptcmd>text.ObjIndent(v:false)<CR>

xnoremap <silent> in <esc><scriptcmd>text.ObjNumber()<CR>
onoremap <silent> in :<C-u>normal vin<CR>

# date text object
xnoremap <silent> id <esc><scriptcmd>text.ObjDate(1)<CR>
onoremap <silent> id :<C-u>normal vid<CR>
xnoremap <silent> ad <esc><scriptcmd>text.ObjDate(0)<CR>
onoremap <silent> ad :<C-u>normal vad<CR>

# line text object
xnoremap <silent> il <esc><scriptcmd>text.ObjLine(1)<CR>
onoremap <silent> il :<C-u>normal vil<CR>
xnoremap <silent> al <esc><scriptcmd>text.ObjLine(0)<CR>
onoremap <silent> al :<C-u>normal val<CR>

# CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
# so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

# spell correction for the first suggested
inoremap <C-l> <C-g>u<ESC>[s1z=`]a<C-g>u

nnoremap <silent> <space># <scriptcmd>text.Underline('#')<CR>
nnoremap <silent> <space>* <scriptcmd>text.Underline('*')<CR>
nnoremap <silent> <space>= <scriptcmd>text.Underline('=')<CR>
nnoremap <silent> <space>- <scriptcmd>text.Underline('-')<CR>
nnoremap <silent> <space>~ <scriptcmd>text.Underline('~')<CR>
nnoremap <silent> <space>^ <scriptcmd>text.Underline('^')<CR>
nnoremap <silent> <space>+ <scriptcmd>text.Underline('+')<CR>
nnoremap <silent> <space>" <scriptcmd>text.Underline('"')<CR>
nnoremap <silent> <space>` <scriptcmd>text.Underline('`')<CR>
nnoremap <silent> <space>. <scriptcmd>text.Underline('.')<CR>
nmap <silent> <space>1 <space>=
nmap <silent> <space>2 <space>-
nmap <silent> <space>3 <space>`

import autoload 'comment.vim'
nnoremap <silent> <expr> gc comment.Toggle()
xnoremap <silent> <expr> gc comment.Toggle()
nnoremap <silent> <expr> gcc comment.Toggle() .. '_'

import autoload 'git.vim'
nnoremap <silent> <space>gi <scriptcmd>git.ShowCommit(v:count)<CR>
xnoremap <silent> <space>gi <scriptcmd>git.ShowCommit(v:count, line("v"), line("."))<CR>
nnoremap <silent> <space>gb <scriptcmd>git.Blame()<CR>
xnoremap <silent> <space>gb <scriptcmd>git.Blame(line("v"), line("."))<CR>
nnoremap <silent> <space>gh <scriptcmd>git.GithubOpen()<CR>
xnoremap <silent> <space>gh <scriptcmd>git.GithubOpen(line("v"), line("."))<CR>

import autoload 'buf.vim'
nnoremap go <nop>
# go to journal file
nnoremap <silent> goj <scriptcmd>buf.EditInTab(expand($DOCS ?? '~/docs') .. '/journal/2023.rst')<CR>
# go to todo file
nnoremap <silent> got <scriptcmd>buf.EditInTab(expand($DOCS ?? '~/docs') .. '/todo.rst')<CR>
# go to *** file
nnoremap <silent> gop <scriptcmd>buf.EditInTab(expand($DOCS ?? '~/docs') .. '/habamax.rst')<CR>

import autoload 'os.vim'
# go to current file in os file manager
nnoremap <silent> gof <scriptcmd>os.FileManager()<CR>
# open URLs
nnoremap <silent> gx <scriptcmd>os.Gx()<CR>


# send to single visible :terminal
import autoload 'term.vim'
xnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>tt term.Send() .. '_'

tnoremap <C-v> <C-w>""

# QuickFix
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]w :lnext<CR>
nnoremap <silent> ]W :llast<CR>
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> [W :lfirst<CR>


# manual folds
nnoremap zf <cmd>set fdm&<CR>zf
xnoremap zf <cmd>set fdm&<CR>zf


# Ripgrep word under cursor
nnoremap <space>8 <scriptcmd>exe "Rg" expand("<cword>")<cr>
xnoremap <space>8 "0y<scriptcmd>exe "Rg" getreg("0")<cr>
