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

# calc visually selected math expression
xnoremap <space>c s
      \<C-r>=system($'perl -e "print {@@->tr("\n", " ")}"')<CR><ESC>`[v`]

# fuzzy
import autoload 'fuzzy.vim'
nnoremap <space>e <scriptcmd>fuzzy.File()<CR>
nnoremap <space>fe <scriptcmd>fuzzy.FileTree()<CR>
nnoremap <space>ge <scriptcmd>fuzzy.GitFile()<CR>
nnoremap <space>b <scriptcmd>fuzzy.Buffer()<CR>
nnoremap <space>h <scriptcmd>fuzzy.Help()<CR>
nnoremap <space>fm <scriptcmd>fuzzy.MRU()<CR>
nnoremap <space>fi <scriptcmd>fuzzy.GitFile(fnamemodify($MYVIMRC, ":p:h"))<CR>
nnoremap <space>fd <scriptcmd>fuzzy.GitFile($DOCS ?? '~/docs')<CR>
nnoremap <space>fD <scriptcmd>fuzzy.File($DOCS ?? '~/docs')<CR>
nnoremap <space>fc <scriptcmd>fuzzy.Colorscheme()<CR>
nnoremap <space>ft <scriptcmd>fuzzy.Template()<CR>
nnoremap <space>fs <scriptcmd>fuzzy.Session()<CR>
nnoremap <space>fb <scriptcmd>fuzzy.Bookmark()<CR>
nnoremap <space>fT <scriptcmd>fuzzy.Filetype()<CR>
nnoremap <space>fh <scriptcmd>fuzzy.Highlight()<CR>
nnoremap <space>fR <scriptcmd>fuzzy.File($VIMRUNTIME)<CR>
nnoremap <space>; <scriptcmd>fuzzy.CmdHistory()<CR>
nnoremap <space>fp <scriptcmd>fuzzy.Project()<CR>
nnoremap <space>j <scriptcmd>fuzzy.DumbJump()<CR>

# enhance search, only if wildcharm is set to <c-z>
if &wildcharm == 26
    cnoremap <expr> <tab>   get({'/': "\<c-g>", '?': "\<c-t>"}, getcmdtype()) ?? "<c-z>"
    cnoremap <expr> <s-tab> get({'/': "\<c-t>", '?': "\<c-g>"}, getcmdtype()) ?? "<s-tab>"
endif

# enhance search with <space> as "whatever"
# to enter literal <space> use <C-v><space>
cnoremap <expr> <space> getcmdtype() =~ '[/?]' ? '.\{-}' : "<space>"

# whitespace
nnoremap <space><space><space> <cmd>FixTrailingSpaces<CR>

# search&replace
nnoremap <space>% :<C-U>%s/\<<C-r>=expand("<cword>")<CR>\>/
xnoremap <space>% y:%s/<C-r>=escape(getreg(), '^~$/\*.[]')->split("\n")->join('\n')<CR>//g<left><left>
xnoremap * y/<C-r>=escape(@", '^~$\*.[]')<CR><CR>

# toggles
nnoremap yow <cmd>set wrap! wrap?<CR>
nnoremap yos <cmd>set spell! spell?<CR>
nnoremap yod <cmd>exe (&diff ? ':diffoff' : ':diffthis')<CR>
nnoremap yov <cmd>&ve = (&ve == "block" ? "all" : "block")<CR><cmd>set ve<CR>
nnoremap yob <cmd>exe "colo" get(g:, "colors_name") == "nods" ? "nopy" : "nods"<CR>

# move lines
xnoremap <tab> :sil! m '>+1<CR>gv
xnoremap <s-tab> :sil! m '<-2<CR>gv

# In visual block { and } navigate to the first/last line of paragraph,
# which is useful if followed by I or A.
def VisualBlockPara(cmd: string)
    if mode() == "\<C-V>"
        var target_row = getpos($"'{cmd}")[1]
        if getline(target_row) =~ "^\s*$"
            target_row += (cmd == "{" ? 1 : -1)
            if target_row == line('.')
                target_row = (cmd == "{" ? prevnonblank(target_row - 1)
                                         : nextnonblank(target_row + 1))
            endif
        endif
        if target_row > 0
            exe $":{target_row}"
        endif
    else
        exe $"normal! {cmd}"
    endif
enddef
xnoremap { <scriptcmd>VisualBlockPara("{")<CR>
xnoremap } <scriptcmd>VisualBlockPara("}")<CR>

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
nnoremap <silent> yoC <ScriptCmd>ToggleCC()<CR>
nnoremap <silent> yoc <ScriptCmd>ToggleCC(true)<CR>

nnoremap <silent> <space><cr> <scriptcmd>text.Toggle()<CR>

# print maybe-function name
nnoremap [f <cmd>echo getline(search('^[[:alpha:]$_]', 'bcnW'))<CR>

# toogle window zoom
import autoload 'zoom.vim'
nnoremap <C-w>o <scriptcmd>zoom.Toggle()<CR>

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
nmap <silent> <space>3 <space>"
nmap <silent> <space>4 <space>`

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
nnoremap <silent> goj <scriptcmd>buf.EditInTab($"{expand($DOCS ?? '~/docs')}/journal/2024.rst")<CR>
# go to todo file
nnoremap <silent> got <scriptcmd>buf.EditInTab($"{expand($DOCS ?? '~/docs')}/todo.rst")<CR>
# go to work todo file
nnoremap <silent> gow <scriptcmd>buf.EditInTab($"{expand($DOCS ?? '~/docs')}/todo-w.rst")<CR>
# go to *** file
nnoremap <silent> gop <scriptcmd>buf.EditInTab($"{expand($DOCS ?? '~/docs')}/habamax.rst")<CR>

import autoload 'os.vim'
# go to current file in os file manager
nnoremap <silent> gof <scriptcmd>os.FileManager()<CR>
# open URLs
nnoremap <silent> gx <scriptcmd>os.Gx()<CR>

tnoremap <C-v> <C-w>""

import autoload 'term.vim'
xnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>tt term.Send() .. '_'

# QuickFix
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]w :lnext<CR>
nnoremap <silent> ]W :llast<CR>
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> [W :lfirst<CR>

# Ripgrep word under cursor
nnoremap <space>8 <scriptcmd>exe "Rg" expand("<cword>")<cr>
xnoremap <space>8 "0y<scriptcmd>exe "Rg" getreg("0")<cr>

# Alt mappings
set <M-n>=n
set <M-p>=p
nnoremap <M-n> gt
nnoremap <M-p> gT
