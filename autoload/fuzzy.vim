vim9script

import autoload 'popup.vim'


export def Buffer()
    var buffer_list = getbufinfo({'buflisted': 1})->mapnew((_, v) => {
                    return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]'), lastused: v.lastused}
                })->sort((i, j) => i.lastused > j.lastused ? -1 : i.lastused == j.lastused ? 0 : 1)
    if buffer_list->len() > 1 && buffer_list[0].bufnr == bufnr()
        [buffer_list[0], buffer_list[1]] = [buffer_list[1], buffer_list[0]]
    endif
    popup.FilterMenu("Buffers", buffer_list,
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
            },
            (winid) => {
                win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
                hi def link FilterMenuDirectorySubtle Comment
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
            },
            (winid) => {
                win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
                hi def link FilterMenuDirectorySubtle Comment
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
                win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
                hi def link FilterMenuDirectorySubtle Comment
            })
enddef


export def Colorscheme()
    popup.FilterMenu("Colorscheme",
            getcompletion("", "color"),
            (res, key) => {
                exe $":colorscheme {res.text}"
            },
            (winid) => {
                win_execute(winid, $'syn match FilterMenuColorscheme "^{g:colors_name}$"')
                hi def link FilterMenuColorscheme Statement
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
                return {text: $"{v.name} ({v.file})", file: v.file, line: v.line, col: v.col}
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
            },
            (winid) => {
                win_execute(winid, 'syn match FilterMenuDirectorySubtle "(.*)$"')
                hi def link FilterMenuDirectorySubtle Comment
            })
enddef


export def File(path: string = "")
    var sep = has("win32") ? '\' : '/'
    var opath = path ?? expand("%:p:h")
    if !isdirectory(opath)
        opath = getcwd()
    endif
    var files = readdirex(opath, (d) => d.type =~ '\%(dir\|linkd\)$')->map((_, v) => {
                return {text: $"{v.name}{sep}", name: v.name, path: opath}
            }) + readdirex(opath, (d) => d.type =~ '\%(file\|link\)$')->map((_, v) => {
                return {text: v.name, name: v.name, path: opath}
            })
    if empty(files)
        files = [{text: "", name: "", path: opath}]
    endif

    popup.FilterMenu(pathshorten(opath), files, (res, key) => {
            if (key == "\<bs>" || key == "\<c-h>") && isdirectory(fnamemodify(res.path, ':p:h:h'))
                File($"{fnamemodify(res.path, ':p:h:h')}")
            elseif isdirectory($"{res.path}{sep}{res.name}")
                File($"{res.path}{res.path[-1] == sep ? '' : sep}{res.name}")
            elseif key == "\<C-j>"
                exe $"split {res.path}{sep}{res.name}"
            elseif key == "\<C-v>"
                exe $"vert split {res.path}{sep}{res.name}"
            elseif key == "\<C-t>"
                exe $"tabe {res.path}{sep}{res.name}"
            else
                exe $"confirm e {res.path}{sep}{res.name}"
            endif
        }, (winid) => {
            win_execute(winid, $"syn match FilterMenuDirectory '^.*{sep->escape('\\')}'")
            hi def link FilterMenuDirectory Directory
        }, true)
enddef


export def FileTree(path: string = "")
    var opath = isdirectory(expand(path)) ? path : getcwd()
    exe $"lcd {opath}"
    def Tree(dir: string): list<string>
        var ignore_dirs = [".git", ".hg", ".bundle"]
        var result = readdirex(dir, (v) => v.type =~ 'file\|link$')->mapnew((_, f) => f.name)
        var dirs = readdirex(dir, (v) => v.type =~ 'dir\|linkd\|junction' && ignore_dirs->index(v.name) == -1)->mapnew((_, f) => f.name)
        while !empty(dirs) && result->len() < 10000 && dirs->len() < 200
            var next_dir = dirs->remove(0)
            result += readdirex(next_dir, (v) => v.type =~ 'file\|link$')->mapnew((_, f) => $"{next_dir}/{f.name}")
            dirs += readdirex(next_dir, (v) => v.type =~ 'dir\|linkd\|junction' && ignore_dirs->index(v.name) == -1)->mapnew((_, f) => $"{next_dir}/{f.name}")
        endwhile
        return result
    enddef
    var files = []
    if executable('fd')
        files = systemlist('fd --path-separator / --type f --hidden --follow --exclude .git')
    elseif executable('rg')
        files = systemlist('rg --path-separator / --files --hidden --glob !.git')
    else
        files = Tree(opath)
    endif
    popup.FilterMenu("File", files,
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
                var projects_file = $'{g:vimdata}/projects.json'
                var projects = []
                try
                    if !filereadable(projects_file)
                        mkdir(fnamemodify(projects_file, ":p:h"), "p")
                    else
                        projects = readfile(projects_file)->join()->json_decode()
                    endif
                    projects->add({path: opath})->sort()->uniq()
                    [projects->json_encode()]->writefile(projects_file)
                catch
                    echohl Error
                    echomsg v:exception
                    echohl None
                endtry
            },
            (winid) => {
                win_execute(winid, 'syn match FilterMenuDirectorySubtle "^.*\(/\|\\\)"')
                hi def link FilterMenuDirectorySubtle Comment
            })
enddef


export def Filetype()
    var ft_list = globpath(&rtp, "ftplugin/*.vim", 0, 1)->mapnew((_, v) => {
        return {text: fnamemodify(v, ":t:r")}
    })->sort()->uniq()
    popup.FilterMenu("Filetype", ft_list,
            (res, key) => {
                exe $":set ft={res.text}"
            })
enddef


export def Highlight()
    var hl = hlget()->mapnew((_, v) => {
        if v->has_key("cleared")
            return {text: $"xxx {v.name} cleared", name: v.name,
                    value: $"hi {v.name}"}
        elseif v->has_key("linksto")
            return {text: $"xxx {v.name} links to {v.linksto}", name: v.name,
                    value: $"hi link {v.name} {v.linksto}"}
        else
            var ctermfg = v->has_key('ctermfg') ? $' ctermfg={v.ctermfg}' : ''
            var ctermbg = v->has_key('ctermbg') ? $' ctermbg={v.ctermbg}' : ''
            var cterm = v->has_key('cterm') ? $' cterm={v.cterm->keys()->join(",")}' : ''
            var guifg = v->has_key('guifg') ? $' guifg={v.guifg}' : ''
            var guibg = v->has_key('guibg') ? $' guibg={v.guibg}' : ''
            var gui = v->has_key('gui') ? $' gui={v.gui->keys()->join(",")}' : ''
            return {text: $"xxx {v.name}{ctermfg}{ctermbg}{cterm}{guifg}{guibg}{gui}",
                    name: v.name,
                    value: $"hi {v.name}{ctermfg}{ctermbg}{cterm}{guifg}{guibg}{gui}"}
        endif
    })
    popup.FilterMenu("Highlight", hl,
        (res, key) => {
            feedkeys($":{res.value}")
        },
        (winid) => {
            win_execute(winid, $"syn match FilterMenuHiLinksTo '\\(links to\\)\\|\\(cleared\\)'")
            hi def link FilterMenuHiLinksTo Comment
            for h in hl
                win_execute(winid, $"syn match {h.name} '^xxx\\ze {h.name}'")
            endfor
        })
enddef


export def Help()
    var help_tags = globpath(&rtp, "doc/tags", 0, 1)->mapnew((_, v) => {
        return readfile(v)->mapnew((_, line) => {
            return {text: line->split("\t")[0]}
        })
    })->flattennew()
    popup.FilterMenu("Help", help_tags,
            (res, key) => {
                if key == "\<c-t>"
                    exe $":tab help {res.text}"
                elseif key == "\<c-v>"
                    exe $":vert help {res.text}"
                else
                    exe $":help {res.text}"
                endif
            })
enddef


export def CmdHistory()
    var cmd_history = [{text: histget("cmd")}] + range(1, histnr("cmd"))->mapnew((i, _) => {
        return {text: histget("cmd", i), idx: i}
    })->filter((_, v) => v.text !~ "^\s*$")->sort((el1, el2) => el1.idx == el2.idx ? 0 : el1.idx > el2.idx ? -1 : 1)
    popup.FilterMenu("Command History", cmd_history,
        (res, key) => {
            feedkeys($":{res.text}\<C-f>")
        })
enddef


export def Project()
    var projects = []
    var projects_file = $'{g:vimdata}/projects.json'
    if filereadable(projects_file)
        try
            projects = readfile(projects_file)->join()->json_decode()->mapnew((_, v) => {
                return {text: v.path}
            })
        catch
            return
        endtry
    endif
    popup.FilterMenu("Project", projects,
            (res, key) => {
                FileTree(res.text)
            })
enddef


export def DumbJump()
    var word = expand("<cword>")
    var lines = []
    for nr in range(1, line('$'))
        var line = getline(nr)
        if line->stridx(word) > -1
            lines->add({text: $"{line} ({nr})", linenr: nr})
        endif
    endfor
    popup.FilterMenu($'Jump with "{word}"', lines,
            (res, key) => {
                exe $":{res.linenr}"
                normal! zz
            },
            (winid) => {
                win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
                hi def link FilterMenuLineNr Comment
            })
enddef
