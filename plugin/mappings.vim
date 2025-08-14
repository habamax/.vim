vim9script

# source vimscript (operator)
def SourceVim(...args: list<any>): string
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif
    if getline(nextnonblank(1) ?? 1) =~ '^\s*vim9script\s*$'
        vim9cmd :'[,']source
    else
        :'[,']source
    endif
    return ''
enddef
nnoremap <silent> <expr> <space>v SourceVim()
xnoremap <silent> <expr> <space>v SourceVim()
nnoremap <silent> <expr> <space>vv SourceVim() .. '_'

# clipboard copy/paste
nnoremap <space>y "+y
xnoremap <space>y "+y
nnoremap <space>p "+p
nnoremap <space>P "+P
xnoremap <space>p "+p
xnoremap <space>P "+P

# duplicate line
nnoremap <C-j> <cmd>copy.<CR>
nnoremap <C-k> <cmd>copy-1<CR>

# fuzzy
import autoload 'fuzzy.vim'
nnoremap <space>e <scriptcmd>fuzzy.File()<CR>
nnoremap <space>b <scriptcmd>fuzzy.Buffer()<CR>
nnoremap <space>r <scriptcmd>fuzzy.MRU()<CR>
nnoremap <space>d <scriptcmd>fuzzy.File($DOCS ?? "~/docs")<CR>
nnoremap <space>h <scriptcmd>fuzzy.Help()<CR>
nnoremap <space>fc <scriptcmd>fuzzy.Colorscheme()<CR>
nnoremap <space>fs <scriptcmd>fuzzy.Session()<CR>
nnoremap <space>fi <scriptcmd>fuzzy.File($MYVIMDIR)<CR>
nnoremap <space>fr <scriptcmd>fuzzy.File($VIMRUNTIME)<CR>
nnoremap <space>it <scriptcmd>fuzzy.Template()<CR>
nnoremap <space>fb <scriptcmd>fuzzy.Bookmark()<CR>
nnoremap <space>fp <scriptcmd>fuzzy.Project()<CR>
nnoremap <space>fh <scriptcmd>fuzzy.Highlight()<CR>
nnoremap <space>fu <scriptcmd>fuzzy.Unicode(v:count)<CR>
nnoremap <space>ft <scriptcmd>fuzzy.Filetype()<CR>

# nnoremap <space>e <scriptcmd>g:SetProjectRoot()<CR>:<C-u>find<space>
# nnoremap <space>b :<C-u>b<space>
# nnoremap <space>r :<C-u>Recent<space>
# nnoremap <space>d <cmd>lcd ~/docs<CR>:<C-u>find<space>
# nnoremap <space>fi <cmd>lcd $MYVIMDIR<CR>:<C-u>find<space>
# nnoremap <space>fr <cmd>lcd $VIMRUNTIME<CR>:<C-u>find<space>
# nnoremap <space>ft :<C-u>set ft=
# nnoremap <space>fs :<C-u>LoadSession<space>
# nnoremap <space>fc :<C-u>colorscheme<space>
# nnoremap <space>it :<C-u>InsertTemplate<space>

# Ripgrep word under cursor
nnoremap <space>fw <scriptcmd>exe 'Rg' expand("<cword>")<cr>
xnoremap <space>fw "0y<scriptcmd>exe "Rg" getreg("0")<cr>

import autoload 'qc.vim'
# calc visually selected math expression
# base64 encode/decode
xnoremap <space>t <scriptcmd>qc.TextTr()<cr>
nnoremap <space>t <scriptcmd>qc.TextTr()<cr>
# # quickfix&locations&diff
nnoremap <silent> <space>n <scriptcmd>qc.Nav()<CR>
# horizontal scroll
nnoremap zl <scriptcmd>qc.HScroll($'normal! {v:count1}zl')<CR>
nnoremap zh <scriptcmd>qc.HScroll($'normal! {v:count1}zh')<CR>
nnoremap zs <scriptcmd>qc.HScroll('normal! zs')<CR>
nnoremap ze <scriptcmd>qc.HScroll('normal! ze')<CR>

# marks
nnoremap ' <scriptcmd>qc.Marks()<CR>

# enhance search with <space> as "whatever"
# to enter literal <space> use <C-v><space>
cnoremap <expr> <space> getcmdtype() =~ '[/?]' ? '.\{-}' : "<space>"

# whitespace
nnoremap <space><space><space> <cmd>FixTrailingSpaces<CR>

# search&replace
nnoremap <space>% :<C-U>%s/\<<C-r>=expand("<cword>")<CR>\>/
xnoremap <space>% y:%s/<C-r>=$'\V{escape(getreg(), '/\\')}'->split("\n")->join('\n')<CR>//g<left><left>
xnoremap * y:let @/ = $"\\V{escape(@@, '\')}"<CR>n
# literal search
nnoremap <space>/ <scriptcmd>exe $"Search {input("Search: ")}"<cr>

# toggles
nnoremap yow <cmd>set wrap! wrap?<CR>
nnoremap yon <cmd>set nu! rnu!<CR>
nnoremap yos <cmd>set spell! spell?<CR>
nnoremap yod <cmd>exe (&diff ? ':diffoff' : ':diffthis')<CR>
nnoremap yov <scriptcmd>&ve = (&ve == "block" ? "all" : "block")<CR><cmd>set ve<CR>
nnoremap yob <cmd>exe &bg == "light" ? g:colors.dark : g:colors.light<CR>

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

# toogle window zoom
import autoload 'zoom.vim'
nnoremap <C-w><C-o> <scriptcmd>zoom.Toggle()<CR>
nmap <C-w>o <C-w><C-o>
# new window
import autoload 'window.vim'
nnoremap <C-w>n <scriptcmd>window.New()<CR>

import autoload 'text.vim'

# simple text objects
# -------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
    execute $"xnoremap <silent> i{char} <esc><scriptcmd>text.Obj('{char}', 1)<CR>"
    execute $"xnoremap <silent> a{char} <esc><scriptcmd>text.Obj('{char}', 0)<CR>"
    execute $"onoremap <silent> i{char} :normal vi{char}<CR>"
    execute $"onoremap <silent> a{char} :normal va{char}<CR>"
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

# git popup commands
nnoremap <space>g <scriptcmd>qc.Git()<CR>
xnoremap <space>g <scriptcmd>qc.Git()<CR>

import autoload 'buf.vim'
nnoremap go <nop>
# go to journal file
nnoremap <silent> goj <scriptcmd>buf.EditInTab($"{expand($DOCS ?? '~/docs')}/journal/2025.rst")<CR>
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

# upcase previous non-upcased word
if !has("gui_running")
    set <M-u>=u
endif
inoremap <M-u> <C-G>u<esc><scriptcmd>search('[[:lower:]]', 'bc', line('.'))<cr>gUiwgi
