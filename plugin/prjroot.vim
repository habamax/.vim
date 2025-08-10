vim9script

# Automatically cd to the project root corresponding to the current buffer.
# Project root is "marked" by specific directories or files.

var rootMarkers = {
    dirs: ['.git', '.hg'],
    files: ['configure', 'Cargo.toml', 'mix.exs', 'go.mod', 'package.json']
}

def g:SetProjectRoot()
    if &buftype != ''
        return
    endif

    if !isdirectory(expand("%:h"))
        return
    endif

    var rootDir = ''
    for dir in rootMarkers.dirs
        rootDir = finddir(dir, expand("%:p:h") .. ";")
        if !rootDir->empty()
            break
        endif
    endfor
    if rootDir->empty()
        for file in rootMarkers.files
            rootDir = findfile(file, expand("%:p:h") .. ";")
            if !rootDir->empty()
                break
            endif
        endfor
    endif

    if !rootDir->empty()
        exe "lcd " .. fnamemodify(rootDir, ":h")
    endif
enddef

augroup prjroot | au!
    au BufEnter * g:SetProjectRoot()
augroup END
