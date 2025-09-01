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
    if empty(bookmark_cache)
        return
    endif
    try
        [bookmark_cache->json_encode()]->writefile(bookmarkFile)
    catch
    endtry
enddef

def BookmarkAdd()
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
            col: col('.'),
            use_dt: localtime()
        }
        bookmark_cache = bookmarks
        BookmarkSave()
    catch
        echohl Error
        echomsg v:exception
        echohl None
    endtry
enddef

command! BookmarkAdd call BookmarkAdd()

command! -nargs=1 -complete=custom,BookmarkComplete Bookmark BookmarkOpen(<f-args>, false, <q-mods>)
command! -nargs=1 -complete=custom,BookmarkComplete SBookmark BookmarkOpen(<f-args>, true, <q-mods>)

def BookmarkComplete(_, _, _): string
    if empty(bookmark_cache) && filereadable(bookmarkFile)
        bookmark_cache = BookmarkLoad()
    endif
    return bookmark_cache
        ->items()
        ->sort((a, b) => a[1].use_dt == b[1].use_dt ? 0 : a[1].use_dt < b[1].use_dt ? 1 : -1)
        ->mapnew((_, v) => v[0])
        ->join("\n")

enddef

def BookmarkOpen(name: string, split: bool = false, mods: string = "")
    var bookmark = get(bookmark_cache, name, null)
    if bookmark == null
        echohl Error
        echomsg $'Bookmark "{name}" not found.'
        echohl None
        return
    endif
    bookmark_cache[name].use_dt = localtime()
    BookmarkSave()
    var guess_mods = ""
    if !empty(mods)
        guess_mods = mods
    elseif split && winwidth(winnr()) * 0.3 > winheight(winnr())
        guess_mods = "vert "
    endif
    exe $"{guess_mods} {split ? "split" : "edit"} {bookmark.file->escape('#%')}"
    cursor(bookmark.line, bookmark.col)
    normal! zz
enddef
