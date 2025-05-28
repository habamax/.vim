vim9script

augroup general | au!
    au Filetype * setl formatoptions=qjlron

    # goto last known position of the buffer
    au BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          |    exe 'normal! g`"'
          | endif

    # create non-existent directory before buffer save
    au BufWritePre *
          \ if !isdirectory(expand("%:p:h"))
          |    mkdir(expand("%:p:h"), "p")
          | endif

    # save last session on exit if there is a buffer with name
    au VimLeavePre *
          \ if reduce(getbufinfo({'buflisted': 1}), (a, v) => a || !empty(v.name), false)
          |    :exe $'mksession! {$MYVIMDIR}.data/sessions/LAST'
          | endif
augroup end

# Commands

# update packages
import autoload "git.vim"
command! PackUp git.PackUpdate()

# Wipe all hidden buffers
def WipeHiddenBuffers()
    var buffers = filter(getbufinfo(), (_, v) => empty(v.windows))
    if !empty(buffers)
        execute 'confirm bwipeout' join(mapnew(buffers, (_, v) => v.bufnr))
    endif
enddef
command! WipeHiddenBuffers WipeHiddenBuffers()

# literal search
command! -nargs=1 Search @/ = $'\V{escape(<q-args>, '\\')}' | normal! n

# fix trailing spaces
command! FixTrailingSpaces :exe 'normal! m`'<bar>
      \ :keepj silent! :%s/\r\+$//g<bar>
      \ :keepj silent! :%s/\v(\s+$)//g<bar>
      \ :exe 'normal! ``'<bar>
      \ :echom 'Remove trailing spaces and ^Ms.'

import autoload "text.vim"
command! -range FixSpaces text.FixSpaces(<line1>, <line2>)

import autoload "share.vim"
command! -range=% -nargs=? -complete=custom,share.Complete Share share.Paste(<q-args>, <line1>, <line2>)

command! CD lcd %:p:h
command! MD call mkdir(expand("%:p:h"), "p")

# syntax group names under cursor
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

# Echo formatted vim objects, e.g. :Echo getbufinfo()
import autoload 'dist/json.vim'
command! -nargs=1 -complete=var Echo redir @"> | echo json.Format(<args>) | redir END

# save and load sessions
if !isdirectory($'{$MYVIMDIR}.data/sessions')
    mkdir($'{$MYVIMDIR}.data/sessions', "p")
endif
command! -nargs=1 -complete=custom,SessionComplete SaveSession :exe $'mksession! {$MYVIMDIR}.data/sessions/<args>'
command! -nargs=1 -complete=custom,SessionComplete LoadSession :%bd <bar> exe $'so {$MYVIMDIR}.data/sessions/<args>'
def SessionComplete(_, _, _): string
    return globpath($'{$MYVIMDIR}.data/sessions/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
enddef

# write to a privileged file
if executable('sudo')
    command! W w !sudo tee "%" >/dev/null
endif

# bookmarks
def SaveBookmark()
    if empty(expand("%")) | return | endif
    var name = input("Save bookmark: ", expand("%:t"))
    if empty(name)
        name = expand("%:t")
    endif
    var bookmarks = {}
    var bookmarkFile = $'{$MYVIMDIR}.data/bookmarks.json'
    try
        if !filereadable(bookmarkFile)
            mkdir(fnamemodify(bookmarkFile, ":p:h"), "p")
        else
            bookmarks = readfile(bookmarkFile)
                ->join()
                ->json_decode()
                ->filter((_, v) => filereadable(v.file))
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


var selected_match = null_string
var allfiles = null_string

augroup livecommands
    au!
    autocmd CmdlineEnter : allfiles = null_string
    autocmd CmdlineLeavePre : SelectItem()
augroup END

def SelectItem()
    selected_match = ''
    if getcmdline() =~ '\v^\s*%(Grep|Rg|Find)\s'
        var info = cmdcomplete_info()
        if info != {} && info.pum_visible && !info.matches->empty()
            selected_match = info.selected != -1 ? info.matches[info.selected] : info.matches[0]
            setcmdline(info.cmdline_orig) # Preserve search pattern in history
        endif
    endif
enddef

# --------------------------
# Find file
# --------------------------
command! -nargs=* -complete=custom,FindFile Find execute(selected_match != '' ? $'edit {selected_match}' : '')
def FindFile(arglead: string, _: string, _: number): string
    var path = get(g:, "fzfind_root", ".")
    if allfiles == null_string
        if executable('fd')
            allfiles = system('fd . --path-separator / --type f --hidden --follow --exclude .git ' .. path)
        elseif executable('fdfind')
            allfiles = system('fdfind . --path-separator / --type f --hidden --follow --exclude .git ' .. path)
        elseif executable('ugrep')
            allfiles = system('ugrep "" -Rl -I --ignore-files ' .. path)
        elseif executable('rg')
            allfiles = system('rg --path-separator / --files --hidden --glob !.git ' .. path)
        elseif executable('find')
            allfiles = system($'find {path} \! \( -path "*/.git" -prune -o -name "*.swp" \) -type f -follow')
        endif
    endif
    return allfiles
enddef

# --------------------------
# Live grep
# --------------------------
command! -nargs=+ -complete=customlist,GrepComplete Grep GrepVisitFile()
def GrepComplete(arglead: string, cmdline: string, cursorpos: number): list<any>
    return arglead->len() > 1 ? systemlist($'grep -REIHns "{arglead}"' ..
       ' --exclude-dir=.git --exclude=".*" --exclude="tags" --exclude="*.swp"') : []
enddef

def GrepVisitFile()
    if (selected_match != null_string)
        var qfitem = getqflist({lines: [selected_match]}).items[0]
        if qfitem->has_key('bufnr') && qfitem.lnum > 0
            var pos = qfitem.vcol > 0 ? 'setcharpos' : 'setpos'
            exec $':b +call\ {pos}(".",\ [0,\ {qfitem.lnum},\ {qfitem.col},\ 0]) {qfitem.bufnr}'
            setbufvar(qfitem.bufnr, '&buflisted', 1)
        endif
    endif
enddef

command! -nargs=+ -complete=customlist,RgComplete Rg GrepVisitFile()
def RgComplete(arglead: string, cmdline: string, cursorpos: number): list<any>
    return arglead->len() > 1 ? systemlist($'rg -nS --column "{arglead}"') : []
enddef

# IRC
def Irc()
    var buf_del = -1
    if (empty(bufname()) || !empty(&buftype)) && !&modified
        buf_del = bufnr()
    endif

    exe "IIJoin irc.libera.chat #vim"
    normal! zb
    wincmd o
    exe "IIJoin irc.libera.chat #perl"
    wincmd L
    normal! zb
    exe "IIJoin irc.libera.chat #python"
    normal! zb
    wincmd t

    # exe "IIJoin irc.libera.chat #vim"
    # normal zb
    # wincmd o
    # exe "IIJoin irc.libera.chat #python"
    # wincmd L
    # normal zb
    # exe "IIJoin irc.libera.chat #perl"
    # normal zb
    # wincmd h
    # exe "IIJoin irc.libera.chat #emacs"
    # normal zb

    if buf_del != -1
        exe $"bd {buf_del}"
    endif

    if !empty($TMUX)
        system('tmux rename-window "irc"')
    endif
enddef
command! Irc Irc()
