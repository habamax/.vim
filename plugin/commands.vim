vim9script

augroup general | au!
    au Filetype * setl formatoptions=qjlron

    # goto last known position of the buffer
    au BufReadPost * {
        if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            exe 'normal! g`"'
        endif
    }

    # create non-existent directory before buffer save
    au BufWritePre * {
        if &modifiable && !isdirectory(expand("%:p:h"))
            mkdir(expand("%:p:h"), "p")
        endif
    }

    # save last session on exit if there is a buffer with name
    au VimLeavePre * {
        if reduce(getbufinfo({'buflisted': 1}), (a, v) => a || !empty(v.name), false)
            :exe $'mksession! {$MYVIMDIR}.data/sessions/LAST'
        endif
    }
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
command! -nargs=1 Search @/ = $'\V{escape(<q-args>, '\')}' | normal! n

# fix trailing spaces
command! FixTrailingSpaces {
    var v = winsaveview()
    keepj silent! :%s/\r\+$//g
    keepj silent! :%s/\v(\s+$)//g
    winrestview(v)
    echom 'Remove trailing spaces and ^Ms.'
}

import autoload "text.vim"
command! -range FixSpaces text.FixSpaces(<line1>, <line2>)

import autoload "share.vim"
command! -range=% -nargs=? -complete=custom,share.Complete Share share.Paste(<q-args>, <line1>, <line2>)

command! CD lcd %:p:h
command! MD call mkdir(expand("%:p:h"), "p")

# syntax group names under cursor
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

import autoload 'dist/json.vim'
# Echo formatted vim objects, e.g. :Echo getbufinfo()
command! -nargs=1 -complete=expression Echo redir @"> | echo json.Format(<args>) | redir END
# Add formatted vim objects to the current buffer, e.g. :EchoHere getbufinfo()
command! -nargs=1 -complete=expression EchoHere append(line('.'), json.Format(<args>)->split("\n"))

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

command! -nargs=1 Grep Sh! grep -Rn <args> .
command! -nargs=1 Rg Sh! rg -nS --column <args> .

def MakeCompletion(_, _, _): string
    return system("make -npq : 2> /dev/null | awk -v RS= -F: '$1 ~ /^[^#%.]+$/ { print $1 }' | sort -u")
enddef

command! -nargs=* -complete=custom,MakeCompletion Make Sh make <args>
