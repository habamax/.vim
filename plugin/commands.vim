vim9script

# Commands


# update packages
import autoload "git.vim"
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
command! FixTrailingSpaces :exe 'normal! m`'<bar>
      \ :keepj silent! :%s/\r\+$//g<bar>
      \ :keepj silent! :%s/\v(\s+$)//g<bar>
      \ :exe 'normal! ``'<bar>
      \ :echom 'Remove trailing spaces and ^Ms.'

command! -range FixSpaces text.FixSpaces(<line1>, <line2>)

command! -range=% -nargs=? -complete=customlist,share#complete Share call share#paste(<q-args>, <line1>, <line2>)

command! GistSync call gist#sync()

command! CD lcd %:p:h
command! MD call mkdir(expand("%:p:h"), "p")

# syntax group names under cursor
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

# save and load sessions
if !isdirectory($'{g:vimdata}/sessions') | mkdir($'{g:vimdata}/sessions', "p") | endif
command! -nargs=1 -complete=custom,SessionComplete SaveSession :exe $'mksession! {g:vimdata}/sessions/<args>'
command! -nargs=1 -complete=custom,SessionComplete LoadSession :%bd <bar> exe $'so {g:vimdata}/sessions/<args>'
def SessionComplete(_, _, _): string
    return globpath($'{g:vimdata}/sessions/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
enddef

# write to a privileged file
if executable('sudo')
    command! W w !sudo tee "%" > /dev/null
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

command! -nargs=1 Rg Sh! rg -nS --column "<args>" .
command! Todo Sh! rg -nS --column "\b(TODO|FIXME|XXX):" .
command! Task Sh! rg -nS --column "\btask:" .

def Irc()
    exe "IIJoin irc.libera.chat #vim"
    wincmd o
    exe "IIJoin irc.libera.chat #python"
    wincmd L
    exe "IIJoin irc.libera.chat #perl"
    wincmd h
    exe "IIJoin irc.libera.chat #emacs"
enddef
command! Irc Irc()
