vim9script

filetype plugin indent on
syntax on

set hidden confirm
set fileformat=unix fileformats=unix,dos
set nohlsearch incsearch ignorecase
set shiftwidth=4 softtabstop=-1 expandtab
set autoindent
set nostartofline virtualedit=block
set ttimeout ttimeoutlen=50
set belloff=all
set ruler
set number signcolumn=number
set shortmess+=Ic
set lazyredraw display=lastline
set completeopt=menu,popup completepopup=highlight:Pmenu
set list listchars=tab:›\ ,nbsp:·,trail:·,extends:→,precedes:←
set nowrap breakindent breakindentopt=sbr,list:-1 linebreak
set formatoptions=cqjl
set backspace=indent,eol,start
set nospell spelllang=ru,en
set commentstring=
set nrformats=bin,hex,unsigned
set foldmethod=indent foldlevelstart=1 foldminlines=2
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set wildmenu wildcharm=<C-z>
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200
set mouse=a ttymouse=sgr
set path=.,,

if executable('rg') | set grepprg=rg\ --vimgrep grepformat=%f:%l:%c:%m | endif

if $TERM =~ '^tmux'
    set background=dark
elseif has("gui_running")
    set background=light
endif
silent! colorscheme habamax


################################################################################
# Non Plugin Mappings

# run legacy vimscript (operator)
def VimL(...args: list<any>): any
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif
    var commands = {"line": "'[V']y", "char": "`[v`]y", "block": "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' .. get(commands, args[0], '')
    :@"
    return ''
enddef
nnoremap <silent> <expr> <space>v <SID>VimL()
xnoremap <silent> <space>v y:@"<CR>
nmap <space>vv V<space>v

# localize it too
nmap <space>мм <space>vv
xmap <silent> <space>м <space>v
nmap <space>м <space>v

g:maplocalleader = "\<space>"

# enhance search, only if wildcharm is set to <C-z>
if &wildcharm == 26
    cnoremap <expr> <Tab>   getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"
    cnoremap <expr> <S-Tab> getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"
endif

nnoremap <space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

# manual folding
nnoremap zf <cmd>setl fdm&<CR>zf
xnoremap zf <cmd>setl fdm&<CR>zf

# toggles
nnoremap <silent> yoh :set hlsearch! hlsearch?<CR>
nnoremap <silent> yow :set wrap! wrap?<CR>
nnoremap <silent> yon :set number! number?<CR>
nnoremap <silent> yor :set relativenumber! relativenumber?<CR>
nnoremap <silent> yol :set list! list?<CR>
nnoremap <silent> yos :set spell! spell?<CR>
nnoremap <silent> yoc :set cursorline! cursorline?<CR>
nnoremap <expr> yod (&diff ? ":diffoff" : ":diffthis") .. "<CR>"
nnoremap <expr> yob ':set bg=' .. (&bg == 'dark' ? "light" : "dark") .. "<CR>"

# windows
def ReadableWin()
    var w = max([90, winwidth(0)])
    var h = max([25, winheight(0)])
    execute 'vertical resize' w
    execute 'resize' h
    setlocal winfixwidth winfixheight
    wincmd =
    setlocal nowinfixwidth nowinfixheight
    normal! ze
enddef
nnoremap <silent> <C-w>m :call <sid>ReadableWin()<CR>
nmap <C-w><C-m> <C-w>m

# buffers
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>
tnoremap <silent> <C-n> <cmd>:bn<CR>
tnoremap <silent> <C-p> <cmd>:bp<CR>

# 26 simple text objects
# ----------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
    execute 'xnoremap <silent> i' .. char .. ' :<C-u>call text#obj("' .. char .. '", 1)<CR>'
    execute 'xnoremap <silent> a' .. char .. ' :<C-u>call text#obj("' .. char .. '", 0)<CR>'
    execute 'onoremap <silent> i' .. char .. ' :normal vi' .. char .. '<CR>'
    execute 'onoremap <silent> a' .. char .. ' :normal va' .. char .. '<CR>'
endfor

# indent text object
onoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
onoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>
xnoremap <silent>ii :<C-u>call text#obj_indent(v:true)<CR>
xnoremap <silent>ai :<C-u>call text#obj_indent(v:false)<CR>

# number text object
def NumberTextObj()
    var rx_num = '\d\+\(\.\d\+\)*'
    if search(rx_num, 'ceW') > 0
        normal! v
        search(rx_num, 'bcW')
    endif
enddef
xnoremap <silent> in :<C-u>call <SID>NumberTextObj()<CR>
onoremap in :<C-u>normal vin<CR>

# date text object
xnoremap <silent> id :<C-u>call text#date_textobj(1)<CR>
onoremap id :<C-u>normal vid<CR>
xnoremap <silent> ad :<C-u>call text#date_textobj(0)<CR>
onoremap ad :<C-u>normal vad<CR>

# CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
# so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

# spell correction for the first suggested
inoremap <C-l> <C-g>u<ESC>[s1z=gi<C-g>u

# syntax group names under cursor
nnoremap <space>ts :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')))<CR>

nnoremap <silent> <space># :call text#underline('#')<CR>
nnoremap <silent> <space>* :call text#underline('*')<CR>
nnoremap <silent> <space>= :call text#underline('=')<CR>
nnoremap <silent> <space>- :call text#underline('-')<CR>
nnoremap <silent> <space>~ :call text#underline('~')<CR>
nnoremap <silent> <space>^ :call text#underline('^')<CR>
nnoremap <silent> <space>+ :call text#underline('+')<CR>
nnoremap <silent> <space>" :call text#underline('"')<CR>
nnoremap <silent> <space>` :call text#underline('`')<CR>

nnoremap <silent> <expr> gc comment#Toggle()
xnoremap <silent> <expr> gc comment#Toggle()
nnoremap <silent> <expr> gcc comment#Toggle() .. '_'

# find visually selected text
xnoremap * y/<C-R>"<CR>

nnoremap <silent> <space>gi :<C-u>call git#show_commit(v:count)<CR>
xnoremap <silent> <space>gi :call git#show_commit(v:count)<CR>
noremap <silent> <space>gb :call git#blame()<CR>

nnoremap go <nop>
# go to journal file
nnoremap <silent> goj :call journal#new()<CR>
# go to todo file
nnoremap <silent> got :exe printf('e %s/todo.txt', expand($DOCS ?? '~/docs'))<CR>
# go to *** file
nnoremap <silent> gop :exe printf('e %s/creds.txt', expand($DOCS ?? '~/docs'))<CR>
# go to current file in os file manager
nnoremap <silent> gof :call os#file_manager()<CR>

# save as
nnoremap <expr> <space>FS printf(":saveas %s%s",
      \ expand("%:p"),
      \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))

# rename (valid if vim-eunuch is installed)
nnoremap <expr> <space>FR printf(":Move %s%s",
      \ expand("%:p"),
      \ empty(expand("%:e")) ? '' : repeat('<Left>', strchars(expand("%:e")) + 1))

# 'array' sort operator
# const whatever = [   ->   const whatever = [
#     'bar',                    'acme',
#     'baz',                    'bar',
#     'foo',                    'baz',
#     'acme'                    'foo'
# ]                         ]
def Sort(..._: list<any>)
    :'[,']sort
    # add commas to every line
    :'[,']s/[^,]$/&,/e
    # remove comma from the last line
    :']s/,$//e
enddef
nmap <silent> gs :set opfunc=<SID>Sort<CR>g@
xmap <silent> gs :sort <bar> s/[^,]$/&,/e <bar> '>s/,$//e<CR>

# gq wrapper that:
# - tries its best at keeping the cursor in place
# - tries to handle formatter errors
def GqFormat(...args: list<any>): string
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif
    if args[0] == 'v'
        normal! gvgq
    else
        normal! '[v']gq
    endif
    if v:shell_error > 0
        silent undo
        redraw
        echomsg 'formatprg "' .. &formatprg .. '" exited with status ' .. v:shell_error
    endif
    if exists("w:gqview")
        call winrestview(w:gqview)
        unlet w:gqview
    endif
    return ''
enddef
nnoremap <silent> gq :let w:gqview = winsaveview()<CR>:set opfunc=<SID>GqFormat<CR>g@
nmap <silent> gqq gq_
xnoremap <silent> gq :<C-U>call <SID>gq_format('v')<CR>

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

# next/prev change for diff mode
nnoremap <silent> ]x :call diff#next_change()<CR>
nnoremap <silent> [x :call diff#prev_change()<CR>

# open URLs
nnoremap <silent> gx :call os#gx()<CR>


################################################################################
# Swap & Backup & Undo

&directory = expand('~/.vimdata/swap//')
&backupdir = expand('~/.vimdata/backup//')
&undodir = expand('~/.vimdata/undo//')
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile


################################################################################
# Autocommands

augroup hlsearch | au!
    au CmdlineEnter /,\? :set hlsearch
    au CmdlineLeave /,\? :set nohlsearch
augroup end

augroup restore_pos | au!
    au BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          |    exe 'normal! g`"'
          | endif
augroup end

if exists("$WSLENV")
    augroup WSLClip | au!
        au TextYankPost * if v:event.regname == '"'
            |   call system("clip.exe ", v:event.regcontents)
            | endif
    augroup END
endif


################################################################################
# Commands

# update packages
command! PlugUp call git#plug_update()

# Wipe all hidden buffers
def WipeHiddenBuffers()
    var buffers = filter(getbufinfo(), (_, v) => v.hidden)
    if !empty(buffers)
        execute 'confirm bwipeout' join(mapnew(buffers, (_, v) => v.bufnr))
    endif
enddef
command! WipeHiddenBuffers WipeHiddenBuffers()

# remove trailing spaces
command! FixTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
      \ :exe 'normal! ``'<bar>
      \ :echo 'Remove trailing spaces and ^Ms.'

command! -range FixSpaces <line1>,<line2>call text#fix_spaces()

command! -range=% -nargs=? -complete=customlist,share#complete Share call share#paste(<q-args>, <line1>, <line2>)

command! GistSync call gist#sync()

command! CD lcd %:p:h

# save and load sessions
var sdir = expand('~/.vimdata/sessions')
if !isdirectory(sdir) | mkdir(sdir, "p") | endif
command! -nargs=1 -complete=customlist,SessionComplete S :mksession! ~/.vimdata/sessions/<args>
command! -nargs=1 -complete=customlist,SessionComplete L :%bd <bar> so ~/.vimdata/sessions/<args>
def SessionComplete(A: string, L: string, P: number): list<string>
    var fullpaths = split(globpath("~/.vimdata/sessions/", "*"), "\n")
    var result = mapnew(fullpaths, (k, v) => fnamemodify(v, ":t"))
    if empty(A)
        return result
    else
        return result->matchfuzzy(A)
    endif
enddef

# write to a privileged file
if executable('sudo')
    command! W w !sudo tee "%" > /dev/null
endif

# open terminal with a cwd of a current buffer
command! Term :bo call term_start(&shell, {"cwd": expand("%:p:h"), "term_finish": "close"})

# redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 -complete=command -bar Redir silent v#redir(<q-args>)

# helper command to use old built-in colorschemes
command! -nargs=1 -complete=color Colo exe "so $VIMRUNTIME/colors/" .. <q-args> .. ".vim"
