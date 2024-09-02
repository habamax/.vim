vim9script

import autoload 'popup.vim'
import autoload 'os.vim'

const MAX_ELEMENTS: number = 20000


export def Buffer()
    var buffer_list = getbufinfo({'buflisted': 1})->mapnew((_, v) => {
        return {bufnr: v.bufnr,
                text: (bufname(v.bufnr) ?? $'[{v.bufnr}: No Name]'),
                lastused: v.lastused,
                winid: len(v.windows) > 0 ? v.windows[0] : -1}
    })->sort((i, j) => i.lastused > j.lastused ? -1 : i.lastused == j.lastused ? 0 : 1)
    # Alternate buffer first, current buffer second
    if buffer_list->len() > 1 && buffer_list[0].bufnr == bufnr()
        [buffer_list[0], buffer_list[1]] = [buffer_list[1], buffer_list[0]]
    endif
    popup.Select("Buffers", buffer_list,
        (res, key) => {
            if key == "\<c-t>"
                exe $":tab sb {res.bufnr}"
            elseif key == "\<c-j>"
                exe $":sb {res.bufnr}"
            elseif key == "\<c-v>"
                exe $":vert sb {res.bufnr}"
            else
                if res.winid != -1
                    win_gotoid(res.winid)
                else
                    exe $":b {res.bufnr}"
                endif
            endif
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectPath '^.*[\\/]'")
            hi def link PopupSelectPath Comment
        })
enddef

export def MRU()
    var mru = []
    mru = v:oldfiles->filter((_, v) =>
        filereadable(fnamemodify(v, ":p")) &&
        v !~ '\~\\AppData\\Local\\Temp\\.*\.tmp' &&
        fnamemodify(v, ":p") !~ escape($VIMRUNTIME, '\')  .. '.*[/\\]doc[/\\].*\.txt'
    )
    popup.Select("MRU", mru,
        (res, key) => {
            if key == "\<c-t>"
                exe $":tabe {res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<c-j>"
                exe $":split {res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<c-v>"
                exe $":vert split {res.text->substitute('#', '\\&', 'g')}"
            else
                exe $":e {res.text->substitute('#', '\\&', 'g')}"
            endif
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectPath '^.*[\\/]'")
            hi def link PopupSelectPath Comment
        })
enddef

export def GitFile(path: string = "")
    var path_e = path->empty() ? "" : $"{path}/"
    var git_cmd = 'git ls-files --other --full-name --cached --exclude-standard'
    var cd_cmd = path->empty() ? "" : $"cd {path} && "
    var git_files = systemlist($'{cd_cmd}{git_cmd}')
    popup.Select("Git File", git_files,
        (res, key) => {
            if key == "\<c-t>"
                exe $":tabe {path_e}{res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<c-j>"
                exe $":split {path_e}{res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<c-v>"
                exe $":vert split {path_e}{res.text->substitute('#', '\\&', 'g')}"
            else
                exe $":e {path_e}{res.text->substitute('#', '\\&', 'g')}"
            endif
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectPath '^.*[\\/]'")
            hi def link PopupSelectPath Comment
        })
enddef

export def Colorscheme()
    var colorschemes = getcompletion("", "color")
        ->sort((i1, i2) => i2 == get(g:, "colors_name", "default") ? 1 : -1)
    popup.Select("Colorscheme",
        colorschemes,
        (res, key) => {
            exe $":colorscheme {res.text}"
        },
        (winid) => {
            if exists("g:colors_name")
                win_execute(winid, $'syn match PopupSelectCurrent "^{g:colors_name}$"')
                hi def link PopupSelectCurrent Statement
            endif
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

    popup.Select("Template",
        tmpls,
        (res, key) => {
            append(line('.'), readfile($"{path}/{res.text}")->mapnew((_, v) => {
                return v->substitute('!!\(.\{-}\)!!', '\=eval(submatch(1))', 'g')
            }))
            if getline('.') =~ '^\s*$'
                del _
            else
                normal! j^
            endif
        })
enddef

export def Session()
    var sessions = glob($'{fnamemodify($MYVIMRC, ":p:h")}/.data/sessions/*', 1, 1)->map((_, v) => fnamemodify(v, ":t"))
    var idx = sessions->index('LAST')
    if idx > -1 && idx != 0
        sessions->remove(idx)
        sessions = ["LAST"] + sessions
    endif
    popup.Select("Session", sessions,
        (res, key) => {
            exe $':%%bd | source {fnamemodify($MYVIMRC, ":p:h")}/.data/sessions/{res.text}'
        })
enddef

export def Bookmark()
    var bookmarks = []
    if filereadable($'{fnamemodify($MYVIMRC, ":p:h")}/.data/bookmarks.json')
        bookmarks = readfile($'{fnamemodify($MYVIMRC, ":p:h")}/.data/bookmarks.json')
            ->join()
            ->json_decode()
            ->items()
            ->mapnew((_, v) => ({text: $"{v[0]} ({v[1].file})", file: v[1].file, line: v[1].line, col: v[1].col}))
            ->filter((_, v) => filereadable(v.file))
    endif
    popup.Select("Bookmark", bookmarks,
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
            win_execute(winid, 'syn match PopupSelectPath "(.*)$"')
            hi def link PopupSelectPath Comment
        })
enddef

export def File(path: string = "")
    var sep = has("win32") ? '\' : '/'
    var opath = expand(path ?? "%:p:h")
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

    popup.Select(pathshorten(opath), files, (res, key) => {
        var escpath = res.path->substitute('#', '\\&', 'g')
        var escname = res.name->substitute('#', '\\&', 'g')
        if (key == "\<bs>" || key == "\<c-h>") && isdirectory(fnamemodify(res.path, ':p:h:h'))
            File($"{fnamemodify(res.path, ':p:h:h')}")
        elseif key == "\<C-o>"
            os.Open($"{res.path}{sep}{res.name}")
        elseif isdirectory($"{res.path}{sep}{res.name}")
            File($"{res.path}{res.path[-1] == sep ? '' : sep}{res.name}")
        elseif key == "\<C-j>"
            exe $"split {escpath}{sep}{escname}"
        elseif key == "\<C-v>"
            exe $"vert split {escpath}{sep}{escname}"
        elseif key == "\<C-t>"
            exe $"tabe {escpath}{sep}{escname}"
        else
            exe $"confirm e {escpath}{sep}{escname}"
        endif
        }, (winid) => {
            win_execute(winid, $"syn match PopupSelectDirectory '^.*{sep->escape('\\')}'")
            hi def link PopupSelectDirectory Directory
        }, true)
enddef

export def FileTree(path: string = "")
    var opath = isdirectory(expand(path)) ? path : ''
    if opath == getcwd()
        opath = ''
    endif

    def Tree(dir: string): list<string>
        var ignore_dirs = [".git", ".hg", ".bundle"]
        var result = readdirex(dir, (v) => v.type =~ 'file\|link$')->mapnew((_, f) => f.name)
        var dirs = readdirex(dir, (v) => v.type =~ 'dir\|linkd\|junction' && ignore_dirs->index(v.name) == -1)->mapnew((_, f) => f.name)
        while !empty(dirs) && result->len() < MAX_ELEMENTS && dirs->len() < 200
            var next_dir = dirs->remove(0)
            result += readdirex(next_dir, (v) => v.type =~ 'file\|link$')->mapnew((_, f) => $"{next_dir}/{f.name}")
            dirs += readdirex(next_dir, (v) => v.type =~ 'dir\|linkd\|junction' && ignore_dirs->index(v.name) == -1)->mapnew((_, f) => $"{next_dir}/{f.name}")
        endwhile
        return result
    enddef
    var files = []

    if executable('fd')
        files = systemlist('fd --path-separator / --type f --hidden --follow --exclude .git ' .. opath)
    elseif executable('rg')
        files = systemlist('rg --path-separator / --files --hidden --glob !.git ' .. opath)
    else
        files = Tree(opath)
    endif
    popup.Select("File", files[ : MAX_ELEMENTS - 1],
        (res, key) => {
            if key == "\<c-t>"
                exe $":tabe {res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<c-j>"
                exe $":split {res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<c-v>"
                exe $":vert split {res.text->substitute('#', '\\&', 'g')}"
            elseif key == "\<C-o>"
                os.Open($"{res.text}")
            else
                exe $":e {res.text->substitute('#', '\\&', 'g')}"
            endif
            var projects_file = $'{fnamemodify($MYVIMRC, ":p:h")}/.data/projects.json'
            var projects = []
            try
                if !filereadable(projects_file)
                    mkdir(fnamemodify(projects_file, ":p:h"), "p")
                else
                    projects = readfile(projects_file)->join()->json_decode()
                endif
                projects->add({path: fnamemodify(opath, ":p")
                    ->trim('\/', 2)})
                    ->sort()
                    ->uniq()
                    ->filter((_, v) => isdirectory(v.path))
                [projects->json_encode()]->writefile(projects_file)
            catch
                echohl Error
                echomsg v:exception
                echohl None
            endtry
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectPath '^.*[\\/]'")
            hi def link PopupSelectPath Comment
        })
enddef

export def Filetype()
    var ft_list = globpath(&rtp, "ftplugin/*.vim", 0, 1)
        ->mapnew((_, v) => ({text: fnamemodify(v, ":t:r")}))
        ->sort()
        ->uniq()
    popup.Select("Filetype", ft_list,
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
            var term = v->has_key('term') ? $' term={v.term->keys()->join(",")}' : ''
            var ctermfg = v->has_key('ctermfg') ? $' ctermfg={v.ctermfg}' : ''
            var ctermbg = v->has_key('ctermbg') ? $' ctermbg={v.ctermbg}' : ''
            var cterm = v->has_key('cterm') ? $' cterm={v.cterm->keys()->join(",")}' : ''
            var guifg = v->has_key('guifg') ? $' guifg={v.guifg}' : ''
            var guibg = v->has_key('guibg') ? $' guibg={v.guibg}' : ''
            var gui = v->has_key('gui') ? $' gui={v.gui->keys()->join(",")}' : ''
            return {text: $"xxx {v.name}{guifg}{guibg}{gui}{ctermfg}{ctermbg}{cterm}{term}",
                    name: v.name,
                    value: $"hi {v.name}{guifg}{guibg}{gui}{ctermfg}{ctermbg}{cterm}{term}"}
        endif
    })
    popup.Select("Highlight", hl,
        (res, key) => {
            feedkeys($":{res.value}\<C-f>")
        },
        (winid) => {
            win_execute(winid, 'syn match PopupSelectHiLinksTo "\(links to\)\|\(cleared\)"')
            hi def link PopupSelectHiLinksTo Comment
            for h in hl
                win_execute(winid, $'syn match {h.name} "^xxx\ze {h.name}\>"')
            endfor
        })
enddef

export def Help()
    var help_tags = globpath(&rtp, "doc/tags", 1, 1)
        ->mapnew((_, v) => readfile(v)->mapnew((_, line) => ({text: line->split("\t")[0]})))
        ->flattennew()
    popup.Select("Help", help_tags,
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
    popup.Select("Command History", cmd_history,
        (res, key) => {
            if key == "\<c-j>"
                feedkeys($":{res.text}\<C-f>", "n")
            else
                feedkeys($":{res.text}\<CR>", "nt")
            endif
        })
enddef

export def Project()
    var projects = []
    var projects_file = $'{fnamemodify($MYVIMRC, ":p:h")}/.data/projects.json'
    if filereadable(projects_file)
        try
            projects = readfile(projects_file)
                ->join()
                ->json_decode()
                ->mapnew((_, v) => ({text: v.path}))
                ->filter((_, v) => isdirectory(v.text))
        catch
            return
        endtry
    endif
    popup.Select("Project", projects,
        (res, key) => {
            FileTree(res.text)
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectPath '^.*[\\/]'")
            hi def link PopupSelectPath Comment
        })
enddef

export def CurrentWord()
    var word = expand("<cword>")
    if empty(trim(word)) | return | endif
    var lines = matchbufline(bufnr(), $'^.*\<{word}\>.*$', 1, '$')
    lines->foreach((_, v) => {
        v.text = $"{v.text} ({v.lnum})"
    })
    popup.Select($'Buffer lines with "{word}"', lines,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, 'syn match PopupSelectLineNr "(\d\+)$"')
            win_execute(winid, $'syn match PopupSelectWord "\c\<{word}\>"')
            win_execute(winid, $'syn match PopupSelectDate "^\u\U\U \d\+ \d\d:\d\d\>"')
            hi def link PopupSelectLineNr Comment
            hi def link PopupSelectWord Statement
            hi def link PopupSelectDate Comment
        })
enddef

export def Window()
    var windows = []
    for w_info in getwininfo()
        var tabtext = tabpagenr('$') > 1 ? $"Tab {w_info.tabnr}, " : ""
        var wintext = $"Win {w_info.winnr}"
        var name = empty(bufname(w_info.bufnr)) ? "[No Name]" : bufname(w_info.bufnr)
        var current_sign = w_info.winid == win_getid() ? "*" : " "
        windows->add({text: $"{current_sign}({tabtext}{wintext}): {name} ({w_info.winid})", winid: w_info.winid})
    endfor
    popup.Select($'Window', windows,
        (res, key) => {
            win_gotoid(res.winid)
        },
        (winid) => {
            win_execute(winid, 'syn match PopupSelectRegular "^ (.\{-}):.*(\d\+)$" contains=PopupSelectBraces')
            win_execute(winid, 'syn match PopupSelectCurrent "^\*(.\{-}):.*(\d\+)$" contains=PopupSelectBraces')
            win_execute(winid, 'syn match PopupSelectBraces "(\d\+)$" contained')
            win_execute(winid, 'syn match PopupSelectBraces "^[* ](.\{-}):" contained')
            hi def link PopupSelectBraces Comment
            hi def link PopupSelectCurrent Statement
        })
enddef
