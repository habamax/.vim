vim9script

filetype plugin indent on
syntax on

set hidden confirm
set fileformat=unix fileformats=unix,dos
set nohlsearch incsearch ignorecase
set shiftwidth=4 softtabstop=-1 expandtab
set autoindent
set nostartofline
set virtualedit=block
set ttimeout ttimeoutlen=50
set belloff=all
set ruler
set signcolumn=number
set shortmess+=Ic
set display=lastline smoothscroll
set completeopt=menu,popup completepopup=highlight:Pmenu
set list listchars=tab:›\ ,nbsp:․,trail:·,extends:…,precedes:…
set fillchars=vert:│
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak
set formatoptions=qjl
set foldmethod=indent foldminlines=4 foldnestmax=3 nofoldenable
set backspace=indent,eol,start
set nospell spelllang=en,ru
set nrformats=bin,hex,unsigned
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set wildmenu wildcharm=<C-z> wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200
set viminfo='200,<50,s10
set mouse=a ttyfast

g:vimdata = $'{has("win32") ? expand("$APPDATA") : expand("~/.config")}/vim-data'
if !isdirectory(g:vimdata) | mkdir(g:vimdata, "p") | endif

&viminfofile = $"{g:vimdata}/viminfo"

if executable('rg')
    set grepprg=rg\ -i\ --vimgrep grepformat=%f:%l:%c:%m
endif


################################################################################
# Non Plugin Mappings

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

g:maplocalleader = "\<space>\<space>"


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
nnoremap <space>j <scriptcmd>fuzzy.DumbJump()<CR>
nnoremap <space>fw <scriptcmd>fuzzy.Window()<CR>


# enhance search, only if wildcharm is set to <C-z>
if &wildcharm == 26
    cnoremap <expr> <Tab>   getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"
    cnoremap <expr> <S-Tab> getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"
endif

# search&replace
nnoremap <space>% :<C-U>%s/\<<C-r>=expand("<cword>")<CR>\>/
xnoremap <space>% y:%s/<C-r>=escape(@", '^~$\&*.[]')<CR>//g<left><left>
nnoremap <space>/ /<C-r>=expand("<cword>")<CR>
xnoremap <space>/ y/<C-R>"
xnoremap * y/<C-R>"<CR>

# toggles
nnoremap yow <cmd>set wrap! wrap?<CR>
nnoremap yos <cmd>set spell! spell?<CR>
nnoremap yod <cmd>exe (&diff ? ':diffoff' : ':diffthis')<CR>
nnoremap yov <scriptcmd>&ve = (&ve == "block" ? "all" : "block")<CR><cmd>set ve<CR>
nnoremap yob <scriptcmd>&bg = (&bg == "light" ? "dark" : "light")<CR>
nnoremap yon <cmd>set rnu! nu! cul!<CR>

# move lines
xnoremap <S-tab> :m '<-2<CR>gv=gv
xnoremap <tab> :m '>+1<CR>gv=gv

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
nnoremap <silent> yoc <ScriptCmd>ToggleCC()<CR>
nnoremap <silent> yoC <ScriptCmd>ToggleCC(true)<CR>

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
nmap <silent> <space>3 <space>.

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
nnoremap <silent> goj <scriptcmd>buf.EditInTab(expand($DOCS ?? '~/docs') .. '/journal/2023.txt')<CR>
# go to todo file
nnoremap <silent> got <scriptcmd>buf.EditInTab(expand($DOCS ?? '~/docs') .. '/todo.txt')<CR>
# go to *** file
nnoremap <silent> gop <scriptcmd>buf.EditInTab(expand($DOCS ?? '~/docs') .. '/creds.txt')<CR>

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


################################################################################
# Swap & Backup & Undo

&directory = expand($'{g:vimdata}/swap/')
&backupdir = expand($'{g:vimdata}/backup//')
&undodir = expand($'{g:vimdata}/undo//')
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile


################################################################################
# Commands

# update packages
command! PackUp git.PackUpdate()

# Wipe all hidden buffers
def WipeHiddenBuffers()
    var buffers = filter(getbufinfo(), (_, v) => v.hidden)
    if !empty(buffers)
        execute 'confirm bwipeout' join(mapnew(buffers, (_, v) => v.bufnr))
    endif
enddef
command! WipeHiddenBuffers WipeHiddenBuffers()

# remove trailing spaces
command! FixTrailingSpaces :silent! :%s/\v(\s+$)|(\r+$)//g<bar>
      \ :exe 'normal! ``'<bar>
      \ :echow 'Remove trailing spaces and ^Ms.'

command! -range FixSpaces text.FixSpaces(<line1>, <line2>)

command! -range=% -nargs=? -complete=customlist,share#complete Share call share#paste(<q-args>, <line1>, <line2>)

command! GistSync call gist#sync()

command! CD lcd %:p:h
command! MD call mkdir(expand("%:p:h"), "p")

# syntax group names under cursor
command! Sy :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')))

# save and load sessions
if !isdirectory($'{g:vimdata}/sessions') | mkdir($'{g:vimdata}/sessions', "p") | endif
command! -nargs=1 -complete=custom,SessionComplete S :exe $'mksession! {g:vimdata}/sessions/<args>'
command! -nargs=1 -complete=custom,SessionComplete L :%bd <bar> exe $'so {g:vimdata}/sessions/<args>'
def SessionComplete(_, _, _): string
    return globpath($'{g:vimdata}/sessions/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
enddef

# write to a privileged file
if executable('sudo')
    command! W w !sudo tee "%" > /dev/null
endif

# open terminal with a cwd of a current buffer
command! Term :bo term_start(&shell, {cwd: expand("%:p:h"), term_finish: "close", "vertical": 1})
if executable("cmd")
    command! Sh silent !start cmd.exe
endif

# base64
command! Base64 append('.', trim(system("python -m base64", getline('.'))))
command! Base64Decode append('.', trim(system("python -m base64 -d", getline('.'))))

# bookmarks
def SaveBookmark()
    if empty(expand("%")) | return | endif
    var name = input("Save bookmark: ", expand("%:t"))
    if empty(name)
        name = expand("%:t")
    endif
    var bookmarks = {}
    var bookmarkFile = $'{g:vimdata}/bookmarks.json'
    try
        if !filereadable(bookmarkFile)
            mkdir(fnamemodify(bookmarkFile, ":p:h"), "p")
        else
            bookmarks = readfile(bookmarkFile)->join()->json_decode()->filter((_, v) => {
                return filereadable(v.file)
            })
        endif
        bookmarks[name] = {file: expand("%:p"), line: line('.'), col: col('.')}
        [bookmarks->json_encode()]->writefile(bookmarkFile)
    catch
        echohl Error
        echomsg v:exception
        echohl None
    endtry
enddef

command! Bookmark call SaveBookmark()


################################################################################
# General autocommands

augroup general | au!
    au CmdlineEnter /,\? set hlsearch
    au CmdlineLeave /,\? set nohlsearch

    au Filetype * setl formatoptions=qjl

    # goto last known position of the buffer
    au BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          |    exe 'normal! g`"'
          | endif

    # create non-existent directory before buffer save
    au BufWritePre *
          \ if !isdirectory(expand("%:p:h"))
          |    call mkdir(expand("%:p:h"), "p")
          | endif

    au VimLeavePre * :exe $'mksession! {g:vimdata}/sessions/LAST'
augroup end


################################################################################
# Colors

# termguicolors support
if !has('win32') && !has('gui_running')
        && $TERM !~ 'xterm'
        && has('termguicolors')
    &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors


def ColorschemeBase()
    var hl = hlget('LineNr')[0]
    hlset([{
        name: 'CursorLineNr',
        ctermbg: hl->has_key('ctermbg') ? hl.ctermbg : 'NONE',
        guibg: hl->has_key('guibg') ? hl.guibg : 'NONE',
        gui: {bold: true}, cterm: {bold: true}
    }])
    hi Comment cterm=italic gui=italic
enddef


def ColorschemeRePire()
    if &background == 'dark'
        hi Normal      ctermbg=NONE guibg=#1c1c1c
        hi TablineSel  ctermbg=NONE guibg=#1c1c1c
        hi Folded      ctermbg=233 guibg=#121212
        hi Cursorline  ctermbg=236 guibg=#303030
        hi Pmenu       ctermbg=237 guibg=#3a3a3a
        hi PmenuSel    ctermbg=214 guifg=#000000 guibg=#ffaf00
        hi ColorColumn ctermfg=16  ctermbg=233    guibg=#121212
    elseif &background == 'light'
        hi Normal       guibg=#f7f7f3
        hi TablineSel   guifg=#f7f7f3
        hi Tabline      guifg=#444444 guibg=#d7d7d0
        hi StatusLineNC guifg=#444444 guibg=#d7d7d0
        hi StatusLine   guibg=#5f5f5f gui=NONE
        hi VertSplit    guibg=#d7d7d0 guifg=#d7d7d0
        hi Cursorline   guibg=#e7e7e0
        hi Folded       guibg=#fffff9
        hi ColorColumn  guibg=#fffff9
        hi PmenuSel     guifg=#ffffff guibg=#d78700
        hi Pmenu        guibg=#deded8
    endif
    hi! link vimVar Normal
enddef


augroup colorschemes | au!
    au Colorscheme * ColorschemeBase()
    au Colorscheme pire ColorschemeRePire()
augroup END


set background=dark
silent! colorscheme pire
