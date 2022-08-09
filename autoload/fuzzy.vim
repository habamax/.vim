vim9script

import autoload 'popup.vim'

export def Buffer()
    popup.FilterMenu("Buffers",
            getbufinfo({'buflisted': 1})->mapnew((_, v) => {
                    return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
                }),
            (res, key) => {
                if key == "\<c-t>"
                    exe $":tab sb {res.bufnr}"
                elseif key == "\<c-j>"
                    exe $":sb {res.bufnr}"
                elseif key == "\<c-v>"
                    exe $":vert sb {res.bufnr}"
                else
                    exe $":b {res.bufnr}"
                endif
            })
enddef


export def MRU()
    popup.FilterMenu("MRU",
            v:oldfiles->copy()->filter((_, v) => {
                return filereadable(expand(v)) &&
                       expand(v)->stridx(expand("$VIMRUNTIME")) == -1
            }),
            (res, key) => {
                if key == "\<c-t>"
                    exe $":tab e {res.text}"
                elseif key == "\<c-j>"
                    exe $":split {res.text}"
                elseif key == "\<c-v>"
                    exe $":vert split {res.text}"
                else
                    exe $":e {res.text}"
                endif
            })
enddef


export def GitFile(path: string = "")
    if !empty(path)
        exe $"lcd {path}"
    endif
    popup.FilterMenu("Git File", systemlist('git ls-files'),
            (res, key) => {
                if key == "\<c-t>"
                    exe $":tab e {res.text}"
                elseif key == "\<c-j>"
                    exe $":split {res.text}"
                elseif key == "\<c-v>"
                    exe $":vert split {res.text}"
                else
                    exe $":e {res.text}"
                endif
            },
            (winid) => {
                win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*/\|\\"')
                hi def link FilterMenuDirectorySubtle Comment
            })
enddef


export def Colorscheme()
    popup.FilterMenu("Colorscheme",
            getcompletion("", "color"),
            (res, key) => {
                exe $":colorscheme {res.text}"
            })
enddef


export def Template()
    var path = $"{fnamemodify($MYVIMRC, ':p:h')}/templates/"
    var ft = getbufvar(bufnr(), '&filetype')
    var ft_path = path .. ft
    var tmpls = []

    if !empty(ft) && isdirectory(ft_path)
        tmpls = mapnew(readdirex(ft_path, (e) => e.type == 'file'), (_, v) => $"{ft}/{v.name}")
    endif

    if isdirectory(path)
        extend(tmpls, mapnew(readdirex(path, (e) => e.type == 'file'), (_, v) => v.name))
    endif

    popup.FilterMenu("Template",
            tmpls,
            (res, key) => {
                append(line('.'), readfile($"{path}/{res.text}"))
                if getline('.') =~ '^\s*$'
                    del _
                else
                    normal! j^
                endif
            })
enddef


export def Session()
    popup.FilterMenu("Session",
            map(glob($'{g:vimdata}/sessions/*', 1, 1), (_, v) => fnamemodify(v, ":t")),
            (res, key) => {
                exe $':%%bd | source {g:vimdata}/sessions/{res.text}'
            })
enddef


export def Bookmark()
    popup.FilterMenu("Bookmark",
            readfile($'{g:vimdata}/bookmarks.json')->join()->json_decode()->mapnew((_, v) => {
                return {text: v.name, file: v.file, line: v.line, col: v.col}
            }),
            (res, key) => {
                if key == "\<C-j>"
                    exe $"split {res.file}"
                elseif key == "\<C-v>"
                    exe $"vert split {res.file}"
                elseif key == "\<C-t>"
                    exe $"tabe {res.file}"
                else
                    exe $"confirm e {res.file}"
                endif
                exe $":{res.line}"
                exe $"normal! {res.col}|"
            })
enddef


export def File(path: string = "")
    var opath = path ?? expand("%:p:h")
    if !isdirectory(opath)
        opath = getcwd()
    endif
    var files = readdirex(opath, (d) => d.type =~ '\%(dir\|linkd\)$')->map((_, v) => {
                return {text: $"{v.name}/", path: opath}
            }) + readdirex(opath, (d) => d.type =~ '\%(file\|link\)$')->map((_, v) => {
                return {text: v.name, path: opath}
            })
    if empty(files)
        files = [{text: "", path: opath}]
    endif

    popup.FilterMenu("File", files, (res, key) => {
            if (key == "\<bs>" || key == "\<c-h>") && isdirectory(fnamemodify(res.path, ':p:h:h'))
                File($"{fnamemodify(res.path, ':p:h:h')}")
            elseif isdirectory($"{res.path}/{res.text}")
                File($"{res.path}/{res.text}")
            elseif key == "\<C-j>"
                exe $"split {res.path}/{res.text}"
            elseif key == "\<C-v>"
                exe $"vert split {res.path}/{res.text}"
            elseif key == "\<C-t>"
                exe $"tabe {res.path}/{res.text}"
            else
                exe $"confirm e {res.path}/{res.text}"
            endif
        }, (winid) => {
            win_execute(winid, 'syn match FilterMenuDirectory "^.*/"')
            hi def link FilterMenuDirectory Directory
        })
enddef
