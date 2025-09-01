vim9script

# Automatically cd to the project root corresponding to the current buffer.
# Project root is "marked" by specific directories or files.

var rootMarkers = {
    dirs: ['.git', '.hg'],
    files: ['configure', 'Cargo.toml', 'mix.exs', 'go.mod', 'package.json']
}

def g:SetProjectRoot()
    if &buftype != '' && ['dir', 'fugitive']->index(&ft) == -1
        return
    endif

    var curdir = expand("%:p:h")
        ->substitute('^dir://', '', '')
        ->substitute('^fugitive:[/\\]\{2}\(.*\)[/\\]\.git', '\1', '')

    if !isdirectory(curdir)
        return
    endif

    var rootdir = ''
    for dir in rootMarkers.dirs
        rootdir = finddir(dir, $"{curdir};")
        if !rootdir->empty()
            break
        endif
    endfor
    if rootdir->empty()
        for file in rootMarkers.files
            rootdir = findfile(file, $"{curdir};")
            if !rootdir->empty()
                break
            endif
        endfor
    endif

    if !rootdir->empty()
        exe "lcd " .. fnamemodify(rootdir, ":h")
    endif
enddef

augroup prjroot | au!
    au BufEnter * g:SetProjectRoot()
augroup END
