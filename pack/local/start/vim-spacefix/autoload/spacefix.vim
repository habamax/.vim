vim9script

# Maintainer: Maxim Kim <habamax@gmail.com>
# Last Update: 2026-07-30

export def Op(): string
    &opfunc = (mode) => NormalizeSpaces(mode)
    if mode() == 'n'
        return ":\<C-U>\<CR>g@"
    else
        return "g@"
    endif
enddef

def NormalizeSpaces(mode: string, pos_start: list<number> = getpos("'["), pos_end: list<number> = getpos("']"))
    var save_lazyredraw = &lazyredraw
    var view = winsaveview()
    set lazyredraw
    defer () => {
        &lazyredraw = save_lazyredraw
        winrestview(view)
    }()

    var lnum_start = pos_start[1]
    var lnum_end = pos_end[1]
    # replace non-breaking space to space first
    exe printf('silent :%d,%ds/\%%xA0/ /ge', lnum_start, lnum_end)
    # replace multiple spaces to a single space (preserving indent)
    exe printf('silent :%d,%ds/\S\+\zs\(\s\|\%%xa0\)\+/ /ge', lnum_start, lnum_end)
    # remove spaces between closed braces: ) ) -> ))
    exe printf('silent :%d,%ds/)\s\+)\@=/)/ge', lnum_start, lnum_end)
    # remove spaces between opened braces: ( ( -> ((
    exe printf('silent :%d,%ds/(\s\+(\@=/(/ge', lnum_start, lnum_end)
    # remove space before closed brace: word ) -> word)
    exe printf('silent :%d,%ds/\s)/)/ge', lnum_start, lnum_end)
    # remove space after opened brace: ( word -> (word
    exe printf('silent :%d,%ds/(\s/(/ge', lnum_start, lnum_end)
    # remove space at the end of line
    exe printf('silent :%d,%ds/\s*$//ge', lnum_start, lnum_end)
enddef
