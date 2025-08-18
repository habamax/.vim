vim9script

var bookmark_cache = {}
var bookmarkFile = $'{$MYVIMDIR}.data/bookmarks.json'

def BookmarkLoad(): dict<any>
    var bookmarks = {}
    try
        bookmarks = readfile(bookmarkFile)
            ->join()
            ->json_decode()
            ->filter((_, v) => filereadable(v.file) || isdirectory(v.file))
    catch
    endtry
    return bookmarks
enddef

def BookmarkSave()
    if empty(expand("%")) | return | endif
    var name = input("Save bookmark: ", expand("%:t"))
    if empty(name)
        name = expand("%:t")
    endif
    var bookmarks = {}
    try
        if !filereadable(bookmarkFile)
            mkdir(fnamemodify(bookmarkFile, ":p:h"), "p")
        else
            bookmarks = BookmarkLoad()
        endif
        bookmarks[name] = {
            file: substitute(expand("%:p"), "^dir://", "", ""),
            line: line('.'),
            col: col('.')
        }
        [bookmarks->json_encode()]->writefile(bookmarkFile)
        bookmark_cache = bookmarks
    catch
        echohl Error
        echomsg v:exception
        echohl None
    endtry
enddef

command! BookmarkSave call BookmarkSave()

command! -nargs=1 -complete=custom,BookmarkComplete Bookmark BookmarkOpen(<f-args>)

def BookmarkComplete(_, _, _): string
    if empty(bookmark_cache) && filereadable(bookmarkFile)
        bookmark_cache = BookmarkLoad()
    endif
    return bookmark_cache->keys()->join("\n")
enddef

def BookmarkOpen(name: string)
    var bookmark = get(bookmark_cache, name, null)
    if bookmark == null
        echohl Error
        echomsg $'Bookmark "{name}" not found.'
        echohl None
        return
    endif
    exe $"edit {bookmark.file}"
    cursor(bookmark.line, bookmark.col)
    normal! zz
enddef
